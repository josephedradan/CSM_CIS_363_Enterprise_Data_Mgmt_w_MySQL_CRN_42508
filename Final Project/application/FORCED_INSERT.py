"""
Created by Joseph Edradan
Github: https://github.com/josephedradan

Date: 5/20/2020

Purpose:

Details:

Description:

Notes:
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

IMPORTANT NOTES:

    CD THEN IN CMD:
        python manage.py shell

    THEN RUN:
         exec(open('FORCED_INSERT.py').read())

Explanation:

Reference:

"""
import os
import sys

from django.contrib.auth.models import User
list_given = [['Username_1', 'Password', 'first_name_1', 'last_name_1', 'Email_1@email.com'],
              ['Username_2', 'Password', 'first_name_2', 'last_name_2', 'Email_2@email.com'],
              ['Username_3', 'Password', 'first_name_3', 'last_name_3', 'Email_3@email.com'],
              ['Username_4', 'Password', 'first_name_4', 'last_name_4', 'Email_4@email.com'],
              ['Username_5', 'Password', 'first_name_5', 'last_name_5', 'Email_5@email.com'],
              ['Username_6', 'Password', 'first_name_6', 'last_name_6', 'Email_6@email.com'],
              ['Username_7', 'Password', 'first_name_7', 'last_name_7', 'Email_7@email.com'],
              ['Username_8', 'Password', 'first_name_8', 'last_name_8', 'Email_8@email.com'],
              ['Username_9', 'Password', 'first_name_9', 'last_name_9', 'Email_9@email.com'],
              ['Username_10', 'Password', 'first_name_10', 'last_name_10', 'Email_10@email.com'],
              ['Username_11', 'Password', 'first_name_11', 'last_name_11', 'Email_11@email.com'],
              ['Username_12', 'Password', 'first_name_12', 'last_name_12', 'Email_12@email.com'],
              ['Username_13', 'Password', 'first_name_13', 'last_name_13', 'Email_13@email.com'],
              ['Username_14', 'Password', 'first_name_14', 'last_name_14', 'Email_14@email.com'],
              ['Username_15', 'Password', 'first_name_15', 'last_name_15', 'Email_15@email.com'],
              ['Username_16', 'Password', 'first_name_16', 'last_name_16', 'Email_16@email.com'],
              ['Username_17', 'Password', 'first_name_17', 'last_name_17', 'Email_17@email.com'],
              ['Username_18', 'Password', 'first_name_18', 'last_name_18', 'Email_18@email.com'],
              ['Username_19', 'Password', 'first_name_19', 'last_name_19', 'Email_19@email.com'],
              ['Username_20', 'Password', 'first_name_20', 'last_name_20', 'Email_20@email.com']]

for i in list_given:
    x = User.objects.create_user(username=i[0], password=i[1], first_name=i[2], last_name=i[3], email=i[4])
    x.save()
    print("Ok")