"""
Healthcare System - Normalized Database Setup Script
Reads denormalized_patient_encounters from healthcare_system
and creates a normalized database (healthcare_system_model_db)
"""

import subprocess
import sys
import os
import getpass


def find_mysql():
    """Find MySQL executable on the system."""
    common_paths = [
        r"C:\xampp\mysql\bin\mysql.exe",
        r"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe",
        r"C:\Program Files\MySQL\MySQL Server 5.7\bin\mysql.exe",
        r"C:\Program Files (x86)\MySQL\MySQL Server 8.0\bin\mysql.exe",
        r"C:\ProgramData\MySQL\MySQL Server 8.0\bin\mysql.exe",
    ]

    # Check if mysql is on PATH
    try:
        result = subprocess.run(
            ["mysql", "--version"],
            capture_output=True, text=True, timeout=10
        )
        if result.returncode == 0:
            return "mysql"
    except (FileNotFoundError, subprocess.TimeoutExpired):
        pass

    # Check common installation paths
    for path in common_paths:
        if os.path.exists(path):
            return path

    return None


def run_sql_file(mysql_path, user, password, sql_file):
    """Execute a SQL file using the mysql command-line client."""
    cmd = [mysql_path, "-u", user]
    if password:
        cmd.append(f"-p{password}")

    sql_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), sql_file)

    if not os.path.exists(sql_path):
        print(f"  ERROR: SQL file not found: {sql_path}")
        return False

    try:
        with open(sql_path, "r", encoding="utf-8") as f:
            result = subprocess.run(
                cmd,
                stdin=f,
                capture_output=True,
                text=True,
                timeout=120
            )

        if result.returncode != 0:
            print(f"  ERROR: {result.stderr.strip()}")
            return False

        if result.stdout.strip():
            print(result.stdout.strip())

        return True

    except subprocess.TimeoutExpired:
        print("  ERROR: Command timed out after 120 seconds")
        return False
    except Exception as e:
        print(f"  ERROR: {e}")
        return False


def verify_source_data(mysql_path, user, password):
    """Check that the source database and table exist with data."""
    cmd = [mysql_path, "-u", user]
    if password:
        cmd.append(f"-p{password}")
    cmd += ["-e", "SELECT COUNT(*) FROM healthcare_system.denormalized_patient_encounters;"]

    try:
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
        if result.returncode != 0:
            return False, result.stderr.strip()

        lines = result.stdout.strip().split("\n")
        if len(lines) >= 2:
            count = int(lines[1].strip())
            return True, count
        return False, "Could not read count"
    except Exception as e:
        return False, str(e)


def main():
    print("=" * 60)
    print("  Healthcare System - Normalized Database Setup")
    print("=" * 60)
    print()

    # Step 1: Find MySQL
    print("[1/4] Finding MySQL installation...")
    mysql_path = find_mysql()
    if not mysql_path:
        print("  ERROR: MySQL not found!")
        print("  Install MySQL or add it to your PATH.")
        sys.exit(1)
    print(f"  Found: {mysql_path}")
    print()

    # Step 2: Get credentials
    print("[2/4] MySQL credentials")
    if len(sys.argv) >= 3:
        user = sys.argv[1]
        password = sys.argv[2]
        print(f"  Using provided credentials (user: {user})")
    else:
        user = input("  Username [root]: ").strip() or "root"
        password = getpass.getpass("  Password: ")
    print()

    # Step 3: Verify source data
    print("[3/4] Verifying source data...")
    exists, info = verify_source_data(mysql_path, user, password)
    if not exists:
        print(f"  ERROR: Source data not available: {info}")
        print("  Make sure healthcare_system database exists with data.")
        print("  Run: mysql -u root -p < healthcare_ddl.sql")
        print("  Then: mysql -u root -p healthcare_system < healthcare_bulk_data.sql")
        sys.exit(1)
    print(f"  Source table has {info} records")
    print()

    # Step 4: Run normalization
    print("[4/4] Running normalization script...")
    print("  - Dropping existing healthcare_system_model_db (if any)")
    print("  - Creating normalized tables")
    print("  - Extracting unique data from denormalized table")
    print("  - Loading into normalized structure")
    print()

    success = run_sql_file(mysql_path, user, password, "normalize_healthcare.sql")

    print()
    if success:
        print("=" * 60)
        print("  SUCCESS! Normalized database created.")
        print("  Database: healthcare_system_model_db")
        print("=" * 60)
    else:
        print("=" * 60)
        print("  FAILED! Check errors above.")
        print("=" * 60)
        sys.exit(1)


if __name__ == "__main__":
    main()
