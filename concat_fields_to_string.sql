/*
 * Query returns a single line of concatenated characters per group.
 */

CREATE TABLE GROUP_BY_XML_EXAMPLE ([GROUP_ID] INT, [DESC_FIELD] VARCHAR(1));

INSERT INTO GROUP_BY_XML_EXAMPLE (GROUP_ID, DESC_FIELD)
VALUES
	(1111, 'J'),
	(1111, 'F'),
	(1111, 'M'),
	(1111, 'A'),
	(1111, 'M'),
	(1112, 'J'),
	(1112, 'J'),
	(1112, 'A'),
	(1112, 'S'),
	(1112, 'O'),
	(1112, 'N'),
	(1112, 'D');

SELECT * FROM GROUP_BY_XML_EXAMPLE

/*  Output:
 *
 *	GROUP_ID	DESC_FIELD
 *	--------	-------------
 *	1111		J
 *	1111		F
 *	1111		M
 *	1111		A
 *	1111		M
 *	1112		J
 *	1112		J
 *	1112		A
 *	1112		S
 *	1112		O
 *	1112		N
 *	1112		D
 *
 */

SELECT
	GBXE1.GROUP_ID,
	(
		SELECT GBXE0.DESC_FIELD + ''
		FROM GROUP_BY_XML_EXAMPLE GBXE0
		WHERE GBXE0.GROUP_ID = GBXE1.GROUP_ID
		FOR XML PATH ('')
	) AS DESC_FIELD_CONCAT
FROM GROUP_BY_XML_EXAMPLE GBXE1
GROUP BY GBXE1.GROUP_ID

/*	Ouput:
 *
 *	GROUP_ID	DESC_FIELD_CONCAT
 *	--------	-----------------
 *	1111		JFMAM
 *	1112		JJASOND
 *
 */