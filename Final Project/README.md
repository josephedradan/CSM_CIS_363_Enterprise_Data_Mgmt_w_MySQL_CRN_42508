# Terrible Amazon Clone

## College of San Mateo CIS 364 Enterprise Data Management with MySQL Final Project

_Description_

A ghetto implementation of Amazon using django and MySQL made within 3 days.

### Demo Images

![image_demo_1.PNG](https://raw.githubusercontent.com/josephedradan/CSM_CIS_363_Enterprise_Data_Mgmt_w_MySQL_CRN_42508/main/Final%20Project/image_demo_1.PNG)

![image_demo_2.PNG](https://raw.githubusercontent.com/josephedradan/CSM_CIS_363_Enterprise_Data_Mgmt_w_MySQL_CRN_42508/main/Final%20Project/image_demo_2.PNG)

![image_demo_3.PNG](https://raw.githubusercontent.com/josephedradan/CSM_CIS_363_Enterprise_Data_Mgmt_w_MySQL_CRN_42508/main/Final%20Project/image_demo_3.PNG)

![image_demo_4.PNG](https://raw.githubusercontent.com/josephedradan/CSM_CIS_363_Enterprise_Data_Mgmt_w_MySQL_CRN_42508/main/Final%20Project/image_demo_4.PNG)

**Joseph Notes**

    Sql stuff

        query project create table.sql
        query project stored functions and procedures.sql
        query project triggers and assertions.sql
        query project views.sql
        query project custom testing.sql
        query project insert into.sql

    Run

        Order of operations to get a DB example:
            1. in MySQL workbench run this line from "query project create table"
                CREATE SCHEMA IF NOT EXISTS `cis_363_project` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
                USE `cis_363_project` ;

            2. Migrate
                python manage.py migrate

            3. Run the entire file
                "query project create table"

            4. Run the files
                "query project stored functions and procedures"
                "query project triggers and assertions"
                "query project views"

            5. In cmd run this file via
                python manage.py shell
                exec(open('FORCED_INSERT.py').read())

            6. In MySQL Workbench run
                "query project insert into"

    Run (2022)

        cd application

        # Load the initial data

        python36 manage.py migrate
        python36 manage.py shell
            exec(open('FORCED_INSERT.py').read())  # Execute this code in the shell

        # Running the server

        python36 -m pip install --upgrade pip
        python36 -m pip install mysqlclient
        python36 -m pip install django-crispy-forms

        python36 manage.py runserver 127.0.0.1:8000
