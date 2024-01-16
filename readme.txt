# Retail Food Store Management System

## Overview

The Retail Food Store Management System is a database system designed to efficiently manage information related to retail food stores, their establishments, licenses, and operations. This README provides essential information to understand, set up, and use the system effectively.

## Database Structure

The system follows a normalized database structure based on the Boyce-Codd Normal Form (BCNF), ensuring data integrity and efficient querying. The primary tables include:

- **County**: Information about counties.
- **Operation**: Details about operations.
- **Establishment**: Comprehensive data about establishments.
- **Establishment_Zip**: Relates establishments to zip codes.
- **License**: License information.

## SQL Queries

The SQL script provided includes various queries for:

- Retrieving and cleaning the dataset.
- Different types of SELECT queries (GROUP BY, sub-query, LIKE, JOIN, ORDER BY).
- Creating BCNF tables.
- Inserting values into tables.
- Indexing for performance optimization.
- Additional queries for data analysis.

## Usage Instructions

1. **Database Setup**:
   - Execute the SQL script in your preferred SQL environment to create tables and set up the database structure.

2. **Data Insertion**:
   - Follow the steps in the script to add necessary columns and insert values into tables.

3. **Indexing**:
   - Create indexes to optimize query performance using the provided SQL commands.

4. **Additional Queries**:
   - Use the additional queries provided to analyze data as needed.

## Customization

- Modify the script based on specific requirements, adding or removing queries as necessary.
- Adjust column names and data types to align with your dataset.

## Execution Analysis

- The script includes an example of analyzing the execution plan for a specific query.



