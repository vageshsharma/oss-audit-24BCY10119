# OSS Audit Project – Apache HTTP Server

  Student Details

* **Name:** Vagesh Sharma
* **Registration Number:** 24BCY10119
* **Course:** Open Source Software (OSS NGMC)

---

  Project Title

**The Open Source Audit – Apache HTTP Server**

---

  Introduction

This project explores the philosophy, structure, and real-world impact of open source software through a detailed audit of the Apache HTTP Server. Alongside theoretical analysis, five Linux shell scripts have been developed to demonstrate practical understanding of system-level operations and automation.

The goal of this project is not only to understand how open source software works, but also why it exists and how it shapes modern computing.

---

  Chosen Software: Apache HTTP Server

The Apache HTTP Server is one of the most widely used open-source web servers in the world. It is developed and maintained by the Apache Software Foundation and is released under the Apache License 2.0.

It plays a critical role in powering websites and enabling open, decentralized access to information on the internet.

---

 Project Structure

```
oss-audit-24BCY10119/
│── script1_system_identity.sh
│── script2_package_inspector.sh
│── script3_disk_auditor.sh
│── script4_log_analyzer.sh
│── script5_manifesto_generator.sh
│── README.md
```

---

## Shell Scripts Overview

###  Script 1: System Identity Report

* Displays system information like:

  * Kernel version
  * Logged-in user
  * Uptime
  * Date & time
* Demonstrates:

  * Variables
  * Command substitution
  * Output formatting

---

###  Script 2: FOSS Package Inspector

* Checks if Apache (or any package) is installed
* Displays:

  * Version
  * License
  * Summary
* Uses:

  * `if-else`
  * `case` statement
  * Package management commands

---

###  Script 3: Disk and Permission Auditor

* Analyzes key Linux directories
* Shows:

  * Disk usage
  * Permissions
  * Ownership
* Uses:

  * `for` loop
  * `du`, `ls -ld`, `awk`

---

###  Script 4: Log File Analyzer

* Reads a log file and counts keyword occurrences
* Default keyword: `error`
* Uses:

  * `while` loop
  * `grep`
  * Counters

---

###  Script 5: Open Source Manifesto Generator

* Takes user input and generates a personalized manifesto
* Saves output in a `.txt` file
* Demonstrates:

  * `read` command
  * String handling
  * File writing

---

##  How to Run the Scripts

### Step 1: Give permission

```bash
chmod +x *.sh
```

### Step 2: Run scripts

```bash
./script1_system_identity.sh
./script2_package_inspector.sh
./script3_disk_auditor.sh
./script4_log_analyzer.sh /var/log/syslog error
./script5_manifesto_generator.sh
```

---

##  Requirements

* Linux Environment (Ubuntu recommended)
* Bash Shell
* Basic Linux utilities (`grep`, `awk`, `du`, etc.)
* Apache HTTP Server (optional for testing Script 2)

---

##  Open Source Philosophy

This project reflects the belief that software should be:

* Accessible
* Transparent
* Collaborative

Open source empowers individuals to learn, modify, and contribute, fostering innovation and collective progress.

---

##  Conclusion

Through this project, I explored both the technical and philosophical dimensions of open source software. The Apache HTTP Server stands as a powerful example of community-driven development and open collaboration.

This audit strengthened my understanding of Linux, shell scripting, and the broader open-source ecosystem.

---

##  Submission Details

* GitHub Repository: *(Add your repo link here)*
* Project Report: Submitted separately as PDF

---

## ⭐ Acknowledgment

This project was completed as part of the Open Source Software course, emphasizing both practical skills and conceptual understanding of open-source systems.
