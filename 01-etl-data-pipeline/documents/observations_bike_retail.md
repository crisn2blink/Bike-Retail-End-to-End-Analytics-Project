# 1\. Observations: Bike Retail Company 2

<br>

## TABLE 1: bronze.chat\_raw\_customers

<br>

**Business Logic Decisions**:

1\. What to do with 0s?

2\. What to do with duplicates?

3\. What to do with NULLS?

4\. What to do with blanks? (below query converts to NULLS)

customer\_id:

- No NULLS
- No duplicates

email:

- No NULLS
- No duplicates

Project Contains Good Examples of:

1\. Email validation

2\. Phone validation

Notes to Keep in Mind Throughout:

1\. Created new column: valid\_email (customers)

\-Make sure to add to silver DDL

2\. Created new column: valid\_phone (customers)

 

* * *

<br>

**IMPORTANT DISCOVERY NOTES**:

1. **CTEs** although might only be created for one or a few columns, these still reference the original table. Thus, in your main query, once you have a CTE, you simply reference the CTE rather than the original table. Just make sure that in your CTE you are selecting ALL of the columns you will need in your main query as well.

2. **DATE**: When using CONVERT, if you specify a style, the string values MUST already be in the format of that specified value, otherwise, this will not work.

- If you have string values that all pass TRY\_CAST DATE, then if you want the date to display as a specific format, you have to use CONVERT(NVARCHAR(10), order\_date, 23) AS order\_date.
- The first step is to make sure that all the string values can pass TRY\_CAST DATE.
- Following, use CONVERT as stated above.
    - However, your data will now be in NVARCHAR format.

<br>

**Take away: Do not convert dates; this will be left up to the analyst when they are doing their analysis on the gold layer.**

**<br>
**

**NOTE**: SQL stores dates but the formats are not saved (**the format will be determined according to your location and system settings**). This is why you cannot specify what format the date will be displayed in; this must be taken care of at ingestion time.

3. **WHERE** while it is true that you can only have a scalar subquery (one that returns one value) and not a list of values in the WHERE clause, you can create a subquery in the WHERE clause that uses IN(subquery) and in this manner find values that are within a specified list of values

4. **CONSTRAINTS**: PRIMARY KEYS AND FOREIGN KEYS

- Always assign a PK not in the column itself, but as a CONSTRAINT at the end of the specific table creation DDL.
    - Why? If this constraint is violated, SQL will clearly state so in error message if done in this manner.
- Assigning FOREIGN KEY constraints makes:
    - "This column is only allowed to contain values that already exist in another table"

<br>

Example: The sales table cannot have a intake a new record where the customer\_id does not already exist in the customer\_id table.

- Make sure when if you add a FK constraint, that you update the main table first in the silver layer and then the table where the key is a foreign key, _very important_.
- Do not perform profiling queries where you from the table with the column as the PK to see if the column values are found in the table with that column as the foreign key (this is backwards)
    - Only perform this query on the table where the keys are foreign to ensure that those values are indeed found in the table w/ the column as the PK

5. **DISTINCT** does not bring back variations in casing, so alter the profiling query for DISTINCT and then future-proof the silver layer query.

- Use “ column COLLATE SQL\_Latin1\_General\_CP1\_CS\_AS AS column” since without COLLATE, SQL does not distinguish capitalization variations!

6. **STANDARDIZATION**: The level of normalization that you implement into the silver-layer query is going to depend on a number of factors. If the company allows for a lot of database resources to go into this query and you want to keep the analyst daily monitoring and manual labor at a minimal, you can standardize each column greatly.

- Adding all of the replace logic solution from your profiling query 0
- Specifically formatting the values to be exactly as the format column format calls for
- Etc.

7. **COLUMN STANDARDIZATION**: When you are going to CHANGE the actual value to a specific format, you need:

- Raw data column
- Validation column
- Corrected value column

If we are ONLY wanting to flag:

- Column (with simple normalization)
- Validation column

8. **WRAPPING SILVER LAYER** **QUERY BEGINNING WITH A CTE** (For testing silver table after data insert with the profiling queries)

- We cannot wrap the query  in a subquery when this begins with a CTE.
    - We must wrap the main query body (after the initial CTE) in a CTE and after this CTE create a SELECT statement referencing the just-created cte (label this cte: test\_cte).

<br>

BUT if we simply insert into the silver table first, you can just do simple SELECT queries to test the silver table; making all of this pointless.

9. **INSERTING INTO WHERE THE QUERY BEGINS WITH A CTE**

- The CTE cannot come after the INSERT INTO clause
    - It must come before it.

1\. CTE

2\. INSERT INTO

3\. MAIN QUERY

10. **USING TRY\_CAST:** Make sure that when we do cleaning and handling of NULL and blank values, that we also add a flag; we do this to identify wether returned NULL values from TRY CAST turned NULL specifically due to failing the TRY\_CAST or if these were NULL prior to the operation; otherwise, we will not know if a values was NULL prior to TRY\_CAST attempt.

11. **FOREIGN KEY CONSTRAINTS**: Do not use if you are using the medallion system because you cannot TRUNCATE tables that are referenced as foreign keys.

12. Set UPPER and TRIM for column standardization when appropriate.

<br>

* * *

<br>
<br>

**QUERIES THAT WE WILL RUN FOR ALL COLUMNS**

1\. Checking for invisible junk in the strings (all column check)

SELECT

    column\_name,

    CONCAT(

        CASE WHEN column\_name != TRIM(column\_name) THEN 'TRIM|' ELSE '' END,

        CASE WHEN column\_name LIKE '%' + CHAR(9)  + '%' THEN 'TAB|'  ELSE '' END,

        CASE WHEN column\_name LIKE '%' + CHAR(10) + '%' THEN 'LF|'   ELSE '' END,

        CASE WHEN column\_name LIKE '%' + CHAR(13) + '%' THEN 'CR|'   ELSE '' END,

        CASE WHEN column\_name LIKE '%' + CHAR(160)+ '%' THEN 'NBSP|' ELSE '' END

    ) AS reasons

FROM table\_name

WHERE column\_name != TRIM(column\_name)

   OR column\_name LIKE '%' + CHAR(9) + '%'

   OR column\_name LIKE '%' + CHAR(10) + '%'

   OR column\_name LIKE '%' + CHAR(13) + '%'

   OR column\_name LIKE '%' + CHAR(160) + '%';

**NOTES**:

1\. This only shows you what is currently wrong with the data as far as invisible junk goes, but you still need to FUTURE PROOF the columns using UPPER(TRIM).

2\. Once you figure out what problems a specific column has (using this query), You use the following query to fix it (using only what is required based on the findings of the above query).

**NULLIF**(

    **TRIM**(

        **REPLACE**(

            **REPLACE**(

                **REPLACE**(

                    **REPLACE**(TRIM(column\_name), CHAR(9), ''),

                CHAR(10), '',

            CHAR(13), ''),

        CHAR(160), '')

    ),

'')

This removes all invisible junk from the column and if what is left at the end is '' (blank), then it NULLS it. So this query takes care of:

1. Invisible Junk
2. Blank values

**OBSERVATIONS**:

1\. customers table:

- City needs to be TRIM

<br>

* * *

<br>

**COLUMN 1**: customer\_id (**primary key**)

- Profiling Query 1 :  Verifying that the table key has only unique values & no NULLS
- Observations 1: All of the values were unique

- Profiling Query 2: Checking for values that do not adhere to the PK pattern (CUST####)
- Observations 2: All of the values adhered to the PK pattern

What we need to fix and the logic behind it:

Data type: NVARCHAR(50)

Future-proofing data pipeline:

1. Added PK CONSTRAINT  to the silver layer DDL
2. Since all customer Ids are upper case, we are adding UPPER(TRIM to the query for the column.
3. (Hypothetical) Will establish data validation constraints within the very fields of the source document to lower the chances of invalid data being ingested.

* * *

<br>

**COLUMN 2**: first\_name

- Profiling Query 1: Visualize the distinct values for the first\_name column
- Observations 1:
    - Names in all caps

Fix:

**UPPER**(**LEFT**(first\_name, 1)) + **LOWER**(**SUBSTRING**(first\_name, 2, **LEN**(first\_name))) AS first\_name,

- Profiling Query 2: Checking for duplicate full\_names
- Observations 2:
    - There are duplicate entries for the customer full\_name

Fix:

- Verified that although there are duplicates for the customers (first and last name) these records are different customers with the same full name (verified by checking email address)

Data Type: NVARCHAR(50)

Future-proofing data pipeline:

1. Adding UPPER(TRIM(LEFT & LOWER(TRIM(SUBSTRING(LEN to make sure that the first name is always in proper case.
2. Handling NULL and blank values with CASE WHEN statement.

* * *

<br>

**COLUMN 3**: last\_name

- Profiling Query 1: Visualize the distinct values for the first\_name column
- Observations 1: no issues found
    - The column has no issues.

Data type: NVARCHAR(50)

Future-proofing data pipeline:

1. Adding UPPER(TRIM(LEFT & LOWER(TRIM(SUBSTRING(LEN to make sure that the first name is always in proper case.
2. Handling NULL and blank values with CASE WHEN statement.

* * *

<br>

**COLUMN 4**: email

- Profiling Query 1: Checking for invalid emails
- Observations 1: all emails were valid

What we need to verify:

1. That the pattern for the emails is correct (valid emails)
2. That there are no duplicates

Although we did not find any issues with the current emails, we will still "future proof" our data pipeline to catch invalid emails by creating a flag within our silver-layer query "is\_valid\_email": INT

Data Type: NVARCHAR(50)

Future-proofing data pipeline:

1. Addressing NULLS and blanks in cte: CTE\_standardization, and adding LOWER(TRIM to the email column.
2. (Hypothetical) Will establish data validation constraints within the very fields of the source document to lower the chances of invalid data being ingested.
3. For debugging purposes, we will create an "email\_raw" column with the untouched original email from the bronze layer.

\*is\_valid\_email

\-FLAG: "1" or "0": if valid, "1"

\-If email is blank or NULL THEN 0

\-If email has no "@" symbol or more than one THEN 0

\-If email does not follow this patter ["%\_@\_%.\_%"](mailto:"%_@_%._%") THEN 0

\-If email address starts or ends with an "@" or "." THEN 0

\-If email address has a "." directly after "@" THEN 0

\-If email has two "." consecutively THEN 0

ELSE 1

* * *

<br>

**COLUMN 5**: phone

- Profiling Query 1: Checking phone\_number for correct pattern (###) ###-####
- Observations 1: Had two different patterns from the established one.

What we need to verify:

1. All phone numbers must be in the correct format (pattern)

<br>

Assumptions:

1. Only customers with phone numbers from the U.S. will have customer records.
2. If by some off-chance there are customers with phone numbers from other countries, we will simply mark these as "n/a"

Data type: NVARCHAR(50)

Correcting current errors & Future-proofing data pipeline:

1. We will create logic within our silver-layer query that will strip all likely non-numeric characters from the phone number; leaving only the digits (as part of the cte: CTE\_standardization)
    - Following, we will proceed to add code to correctly format the stripped phone number within the main query.
2. Adding a "is\_valid\_phone": INT column where we verify that the whether the stripped phone number is valid syntax-wise.
3. We will also create a "phone\_raw" column with the original value from the bronze layer for debugging purposes.
4. (Hypothetical) Will establish data validation constraints within the very fields of the source document to lower the chances of invalid data being ingested.

* * *

<br>

**COLUMN 6**: city

- Profiling Query 1: Checking city for DISTINCT values
- Observations 1: All DISTINCT city values are valid

What we need to verify:

1. We know that we have to use TRIM from our initial profiling query
2. We need to make sure that the unique values are all valid

Data type: NVARCHAR(50)

Future-proofing data pipeline:

1. Adding UPPER(TRIM to the city column to keep leading and trailing spaces out as well as to enhance aggregation capabilities,
2. Handling NULL and blank values with CASE WHEN statement.

* * *

<br>

**COLUMN 7**: state

- Profiling Query 1: Checking state for DISTINCT values
- Observations 1: All DISTINCT values are valid

What we need to verify:

1. We need to make sure that the unique values are all valid

Data type: NVARCHAR(50)

Future-proofing data pipeline:

1. Adding UPPER(TRIM to the state column to keep leading and trailing spaces out and ensure that entries are in all-caps.
2. (Hypothetical) Will add validation restrictions to source documents so as to prevent invalid-data entry at the source.
3. Handling NULL and blank values with CASE WHEN statement.

* * *

<br>

**COLUMN 8**: signup\_date

- Profiling Query 1: Checking signup\_date for invalid date values
- Observations 1: No invalid dates present.

- Profiling Query 2: Checking signup\_date for impossible date values
- Observations 2: No impossible dates found.

What we need to verify:

1. Check to see what values are not valid dates within the column

Data type: DATE

2. Check that there are no dates in the future or way in the past.

Future-proofing data pipeline:

1. (Hypothetical) Set up data validation restrictions in at the source system.
2. Run profiling query as CTE on silver query to see if any values failed TRY\_CAST
3. Handling NULL and blank values with CASE WHEN statement.

* * *

<br>

**COLUMN 9**: customer\_segment

- Profiling Query 1: Checking customer\_segment for DISTINCT values
- Observations 1: There are four valid customer segments.

What we need to verify:

1. Ensure that the DISTINCT customer segments are valid categories.

Data type: NVARCHAR(50)

 Future-proofing data pipeline:

1. Adding code to silver layer query to ensure that casing is respected and that leading and trailing spaces are removed.
2. (Hypothetical) Set up data validation restrictions in at the source system.
3. Handling NULL and blank values with CASE WHEN statement.

* * *

<br>
<br>

SUMMARY OF WHAT WAS DONE TO THIS PARTICULAR TABLE

- trimming and standardizing text
- normalizing case
- formatting phone numbers
- creating validation flags instead of deleting rows
- using TRY\_CAST for date conversion
- turning blanks into NULL

CONSTRAINTS

1\. Primary\_Key for customer\_id

<br>

* * *

<br>

* * *

<br>
<br>

## TABLE 2: bronze.chat\_raw\_products

**NOTES TO KEEP IN MIND THROUGHOUT**:

1\. Created additional column: invalid\_model

* * *

<br>
<br>

**QUERIES THAT WE WILL RUN FOR ALL COLUMNS**

1\. Checking for invisible junk in the strings (all column check)

SELECT

    column\_name,

    CONCAT(

        CASE WHEN column\_name != TRIM(column\_name) THEN 'TRIM|' ELSE '' END,

        CASE WHEN column\_name LIKE '%' + CHAR(9)  + '%' THEN 'TAB|'  ELSE '' END,

        CASE WHEN column\_name LIKE '%' + CHAR(10) + '%' THEN 'LF|'   ELSE '' END,

        CASE WHEN column\_name LIKE '%' + CHAR(13) + '%' THEN 'CR|'   ELSE '' END,

        CASE WHEN column\_name LIKE '%' + CHAR(160)+ '%' THEN 'NBSP|' ELSE '' END

    ) AS reasons

FROM table\_name

WHERE column\_name != TRIM(column\_name)

   OR column\_name LIKE '%' + CHAR(9) + '%'

   OR column\_name LIKE '%' + CHAR(10) + '%'

   OR column\_name LIKE '%' + CHAR(13) + '%'

   OR column\_name LIKE '%' + CHAR(160) + '%';

**NOTES**:

1\. This only shows you what is currently wrong with the data as far as invisible junk goes, but you still need to FUTURE PROOF the columns using UPPER(TRIM).

2\. Once you figure out what problems a specific column has (using this query), You use the following query to fix it (using only what is required based on the findings of the above query).

**NULLIF**(

    **TRIM**(

        **REPLACE**(

            **REPLACE**(

                **REPLACE**(

                    **REPLACE**(TRIM(column\_name), CHAR(9), ''),

                CHAR(10), '',

            CHAR(13), ''),

        CHAR(160), '')

    ),

'')

This removes all invisible junk from the column and if what is left at the end is '' (blank), then it NULLS it. So this query takes care of:

1\. Invisible Junk

2\. Blank values

**OBSERVATIONS**: (of above query)

1\. Category column needs to be TRIM

<br>

* * *

<br>
<br>

**COLUMN 1**: product\_id

- Profiling Query 1: Verifying that the table key has only unique values
- Observations 1: All of the values are unique

- Profiling Query 2: Verifying that PK has no NULLS or blanks
- Observations 2: There are no NULLS or blanks present.

- Profiling Query 3: Checking for values that do not adhere to the PK pattern
- Observations 3: All values adhere to the PK pattern

What we need to verify:

Data type: NVARCHAR(50): PRIMARY KEY

Future-proofing data pipeline:

1. Adding CONSTRAINT Primary Key (product\_id) to silver layer DDL
2. Since all customer Ids are upper case, we are adding UPPER(TRIM to the query for the column.
3. (Hypothetical) Will establish data validation constraints within the very fields of the source document to lower the chances of invalid data being ingested.

* * *

<br>

**COLUMN 2**: brand

- Profiling Query 1: Checking for the DISTINCT values in brand (using case sensitivity)
- Observations 1: There are variations of the brands where the first character is not capitalized.

What we need to verify:

Data type: NVARCHAR(50)

Future-proofing data pipeline:

1. (Hypothetical) Adding drop-down menu selection for the brand in source file (data validation).
2. Including CASE WHEN statement to handle NULLS and blanks as well as fix individual capitalization cases. We will also apply TRIM to increase column normalization.

* * *

<br>

**COLUMN 3**: category

- Profiling Query 1: Checking for the DISTINCT values in category (using case sensitivity)
- Observations 1: There were several identical values. We know from query 0 that this is due to some having leading and trailing spaces.

What we need to verify:

1. We need to make sure and TRIM the column (since query 0 found leading and/or trailing spaces).
2. We need to see all of the variations of categories and make sure these are valid (using case sensitive query).

Data type: NVARCHAR(50)

Future-proofing data pipeline:

1. Including CASE WHEN statement to handle NULLS and blanks and apply TRIM to increase normalization.
2. (Hypothetical) Adding drop-down menu selection for the category in source file (data validation).

* * *

<br>

**COLUMN 4**: model\_number

- Profiling Query 1: Checking for the DISTINCT values in model\_number (using case sensitivity)
- Observations 1:

1. All model numbers are valid

What we need to verify:

1. Ensure that all model numbers are valid

Data type: NVARCHAR(50)

Future-proofing data pipeline:

1. (Hypothetical) In the source document, adding data validation constraints by having a drop-down menu for possible model numbers.
2. Creating a flag column (invalid\_model: INT) to check for model\_number validity. We are not modifying the model number structure aside from using TRIM.

* * *

<br>

**COLUMN 5**: color

- Profiling Query 1: Checking for the DISTINCT values in color (using case sensitivity)
- Observations 1: All colors have a proper case and a lower case variant.

What we need to verify:

1. Makes sure that all colors are valid
2. That there are no casing variants

Data type: NVARCHAR(50)

Future-proofing data pipeline:

1. Will force proper casing along with TRIM on the column "color".
2. (Hypothetical) In the source document, adding data validation constraints by having a drop-down menu for possible colors.

* * *

<br>

**COLUMN 6**: material

- Profiling Query 1: Checking for the DISTINCT values in material (using case sensitivity)
- Observations 1: There are casing variants amongst the materials

What we need to verify:

1. Ensure that all materials are valid
2. Standardize casing

Data type: NVARCHAR(50)

Future-proofing data pipeline:

1. Will use UPPER(TRIM on the column to normalize it.
2. (Hypothetical) In the source document, adding data validation constraints by having a drop-down menu for possible materials.

* * *

<br>

<br>

**COLUMN 7**: list\_price

- Profiling Query 1: Checking for the invalid values against data type DECIMAL(10,2) in list\_price
- Observations 1: There are no values that fail TRY\_CAST

What we need to verify:

1. If there are any columns that fail TRY\_CAST DECIMAL(10,2) data type.

Data type: DECIMAL(10,2)

Future-proofing data pipeline:

1. Nothing needs to be done here since the column will be typed as DECIMAL(10,2). If non-standardized data is loaded, the system will give an error.

* * *

<br>

**COLUMN 8**: standard\_cost

- Profiling Query 1: (Checking for the invalid values against data type DECIMAL(10,2) in standard\_cost
- Observations 1: There are no values that fail TRY\_CAST

What we need to verify:

1. If there are any columns that fail TRY\_CAST DECIMAL(10,2) data type.

Data type: DECIMAL(10,2)

Future-proofing data pipeline:

1. Nothing needs to be done here since the column will be typed as DECIMAL(10,2). If non-standardized data is loaded, the system will give an error.

* * *

<br>

**COLUMN 9**: is\_active

- Profiling Query 1: Checking for the DISTINCT values in is\_valid (using case sensitivity)
- Observations 1: There were values that we need to replace: "Y", "N".

What we need to verify:

1. That there are only "Yes" and "No" values

Data type: NVARCHAR(10)

Future-proofing data pipeline:

1. (Hypothetical) In the source document, we will implement data validation in the fields that the data is stored.
2. Using CASE WHEN statement to convert values from "Y" and "N".

* * *

<br>

<br>

SUMMARY OF WHAT WAS DONE TO THIS PARTICULAR TABLE

- Data cleaning
- Data validation
- Data typing
- Primary key validation

<br>

* * *

<br>

* * *

<br>

## TABLE 3: bronze.chat\_raw\_sales

**NOTES TO KEEP IN MIND THROUGHOUT**:

1\. Make sure that all of the values for columns that are foreign keys, are found within the primary keys of their respective tables.

2\. Created a new column "order\_date\_failed"

3\. Created a new column "quantity\_failed"

4\. Created a new column "unit\_price\_failed"

5\. Created a new column "sales\_amount\_failed"

 

* * *

<br>

**QUERIES THAT WE WILL RUN FOR ALL COLUMNS**

1\. Checking for invisible junk in the strings (all column check)

SELECT

    column\_name,

    CONCAT(

        CASE WHEN column\_name != TRIM(column\_name) THEN 'TRIM|' ELSE '' END,

        CASE WHEN column\_name LIKE '%' + CHAR(9)  + '%' THEN 'TAB|'  ELSE '' END,

        CASE WHEN column\_name LIKE '%' + CHAR(10) + '%' THEN 'LF|'   ELSE '' END,

        CASE WHEN column\_name LIKE '%' + CHAR(13) + '%' THEN 'CR|'   ELSE '' END,

        CASE WHEN column\_name LIKE '%' + CHAR(160)+ '%' THEN 'NBSP|' ELSE '' END

    ) AS reasons

FROM table\_name

WHERE column\_name != TRIM(column\_name)

   OR column\_name LIKE '%' + CHAR(9) + '%'

   OR column\_name LIKE '%' + CHAR(10) + '%'

   OR column\_name LIKE '%' + CHAR(13) + '%'

   OR column\_name LIKE '%' + CHAR(160) + '%';

**NOTES**:

1. This only shows you what is currently wrong with the data as far as invisible junk goes, but you still need to FUTURE PROOF the columns using UPPER(TRIM).

2. Once you figure out what problems a specific column has (using this query), You use the following query to fix it (using only what is required based on the findings of the above query).

**NULLIF**(

    **TRIM**(

        **REPLACE**(

            **REPLACE**(

                **REPLACE**(

                    **REPLACE**(TRIM(column\_name), CHAR(9), ''),

                CHAR(10), '',

            CHAR(13), ''),

        CHAR(160), '')

    ),

'')

This removes all invisible junk from the column and if what is left at the end is '' (blank), then it NULLS it. So this query takes care of:

1. Invisible Junk
2. Blank values

<br>

**Observations:** (of above query)

- No invisible junk in any of the columns.

<br>

* * *

<br>
<br>

**COLUMN 1**: sale\_id

- Profiling Query 1: Verifying that the table key has only unique values & no NULLS
- Observations 1: All of the sale\_id values are unique.

- Profiling Query 2: Verifying that PK has no NULLS or blanks
- Observations 2: There are no NULL or blank values in the PK.

- Profiling Query 3: Checking for values that do not adhere to the PK pattern
- Observations 3: All values adhere to the expected pattern.

What we need to verify:

1. The PK is unique
2. There are no NULL or blank values
3. All values adhere to the PK pattern

Data type: NVARCHAR(50)

Future-proofing data pipeline:

1. Setting the Primary Key constraint for the table.
2. Adding UPPER(TRIM to the column SELECT statement
3. (Hypothetical) In the source document, we will implement data validation in the fields that the data is stored.

* * *

<br>

**COLUMN 2**: customer\_id

- Profiling Query 1: Verify that all foreign key values are found in the PK table
- Observations 1: All values are accounted for in the table silver.chat\_raw\_customers.

What we need to verify:

1. All foreign key values are accounted for.

Data type: NVARCHAR(50)

Future-proofing data pipeline:

1. Adding Foreign Key CONSTRAINT
2. Adding UPPER(TRIM to the column SELECT statement
3. (Hypothetical) In the source document, we will implement data validation in the fields that the data is stored.

* * *

<br>

**COLUMN 3**: product\_id

- Profiling Query 1: Verify that all foreign key values are found in the PK table
- Observations 1: All values are accounted for in the table silver.chat\_raw\_products.

What we need to verify:

1. All foreign key values are accounted for.

Data type: NVARCHAR(50)

Future-proofing data pipeline:

1. Adding Foreign Key CONSTRAINT
2. Adding UPPER(TRIM to the column SELECT statement
3. (Hypothetical) In the source document, we will implement data validation in the fields that the data is stored.

* * *

<br>

**COLUMN 4**: order\_date

- Profiling Query 1: Verify that all values in order\_date are DATE type compatible
- Observations 1: All values are compatible with DATE data type.

What we need to verify:

1. Find any values not compatible with the DATE data type.

Data type: DATE

Future-proofing data pipeline:

1. Will have data typed to DATE
2. We will create a new column to flag the order\_date values that failed TRY\_CAST: order\_date\_failed
3. (Hypothetical) In the source document, we will implement data validation in the fields that the data is stored.

* * *

<br>

**COLUMN 5**: quantity

- Profiling Query 1: Check all of the DISTINCT values (w/ casing sensitivity) for quantity
- Observations 1: All values are valid entries

- Profiling Query 2: Check all the values to see if these are INT type compatible
- Observations 2: All current values pass TRY\_CAST AS INT.

What we need to verify:

1. Ensure that all current values are valid
2. Check if the values are INT data type compatible

Data type: INT

Future-proofing data pipeline:

1. We will have data typed to INT.
2. We will create a new column to flag the quantity values that failed TRY\_CAST: quantity\_failed.
3. (Hypothetical) In the source document, we will implement data validation in the fields that the data is stored.

* * *

<br>

**COLUMN 6**: unit\_price

- Profiling Query 1: --Profiling Query 9: Check to see if there are any values that fail TRY\_CAST DECIMAL(10,2) in unit\_price.
- Observations 1: All of the values pass TRY\_CAST.

What we need to verify:

1. Ensure that all of the values pass TRY\_CAST AS DECIMAL(10,2)

Data type: DECIMAL(10,2)

Future-proofing data pipeline:

1. We will have data typed to DECIMAL(10,2).
2. We will create a new column to flag the unit\_price values that failed TRY\_CAST: unit\_price\_failed
3. (Hypothetical) In the source document, we will implement data validation in the fields that the data is stored.

* * *

<br>

**COLUMN 7**: sales\_amount

- Profiling Query 1: Check to see if there are any values that fail TRY\_CAST DECIMAL(10,2) in sales\_amount
- Observations 1: All of the values pass TRY\_CAST

What we need to verify:

1. Ensure that all of the values pass TRY\_CAST AS DECIMAL(10,2)

Data type: DECIMAL(10,2)

Future-proofing data pipeline:

1. We will have data typed to DECIMAL(10,2).
2. We will create a new column to flag the sales\_amount values that failed TRY\_CAST: sales\_amount\_failed
3. (Hypothetical) In the source document, we will implement data validation in the fields that the data is stored.

* * *

<br>

**COLUMN 8**: sales\_channel

- Profiling Query 1: Check all of the DISTINCT values (w/ casing sensitivity) for sales\_channel
- Observations 1: There are capitalization variants for each of the valid sales channels.

What we need to verify:

1. Ensure that all of the sales channels are unique and have proper capitalization.

Data type: NVARCHAR(50)

Future-proofing data pipeline:

1. Creating a CASE WHEN statement that:
    - Accounts for blank and NULL values
    - Enforces proper casing for single word values
    - Leaves all other values as they are (for debugging purposes).
2. (Hypothetical) In the source document, we will implement data validation in the fields that the data is stored.

* * *

<br>

**COLUMN 9**: store\_name

- Profiling Query 1: Check all of the DISTINCT values (w/ casing sensitivity) for store\_name
- Observations 1: There are ALL CAPS variants for each of the valid store\_name values.

- Profiling Query 2: (actual query along with a description of what we are doing)
- Observations 2: (the results of the query)

<br>

What we need to verify:

1. Ensure that all store names are valid and unique

Data type: NVARCHAR(50)

Future-proofing data pipeline:

1. Creating a CASE WHEN statement that:
    - Accounts for blank and NULL values
    - Enforces proper casing (since we know the name format for all of our stores is the same)
    - Leaves all other values as they are (for debugging purposes).
2. (Hypothetical) In the source document, we will implement data validation in the fields that the data is stored.

* * *

<br>

**COLUMN 10**: payment\_method

- Profiling Query 1: Check all of the DISTINCT values (w/ casing sensitivity) for payment\_method
- Observations 1: There are lower-case variants for all of the properly-cased payment methods.

What we need to verify:

1. Ensure that all payment methods are valid and unique

Data type: NVARCHAR(50)

Future-proofing data pipeline:

1. Creating a CASE WHEN statement that:
    - Accounts for blank and NULL values
    - Deals with individual cases separately (since there are a limited number of payment methods).
    - Leaves all other values as they are (for debugging purposes).
2. (Hypothetical) In the source document, we will implement data validation in the fields that the data is stored.

* * *

<br>

SUMMARY OF WHAT WAS DONE TO THIS PARTICULAR TABLE

\-Data cleaning

\-Data validation

\-Data typing

\-Primary key validation

\-Foreign key validations

CONSTRAINTS

sale\_id Primary Key

customer\_id Foreign Key

product\_id Foreign Key

<br>

 

* * *

<br>

* * *

<br>

**<br>
**

**GOLD LAYER NOTES**

Data model: Star Schema

**Column name changes**:

Table 1: customers: none

Table 2: products:

- list\_price AS selling\_price
- standard\_cost AS cost

Table 3: sales:

- unit\_price AS sale\_price
- sales\_amount AS sales\_revenue

**Business Objects Summary:**

1.  gold.dim\_customers
2. gold.dim\_products
3. gold.fact\_sales

**DATA INTEGRATION**

Table 3: gold.fact\_sales

Issue: unit\_price and selling\_price do not match.

<br>

- Used the following query to gain insight in regard to how: unit\_price, selling\_price and standard\_cost all relate to one another.

SELECT DISTINCT

p.model\_name,

s.unit\_price,

p.selling\_price,

p.cost

FROM silver.chat\_raw\_sales AS s

LEFT JOIN gold.dim\_customers AS c

ON s.customer\_id = c.customer\_id

LEFT JOIN gold.dim\_products AS p

ON s.product\_id = p.product\_id

ORDER BY 1,2,3,4;

unit\_price has to stay because this is linked to the quantity and the sales\_amount in silver.chat\_raw\_sales table.

Verified that in silver.chat\_raw\_sales table, all records had the following conditions:

quantity \* unit\_price = sales\_amount

SELECT\*

FROM silver.chat\_raw\_sales

WHERE quantity \* unit\_price = sales\_amount

**Decision**:

- Simply leave out the selling\_price column
- Change the name of unit\_price to sale\_price
