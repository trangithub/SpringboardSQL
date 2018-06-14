/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

SQL query: SELECT * FROM `Facilities` WHERE ( membercost >0 ) LIMIT 0 , 30;


facid	name	membercost	guestcost	initialoutlay	monthlymaintenance	
0	Tennis Court 1	5.0	25.0	10000	200
1	Tennis Court 2	5.0	25.0	8000	200
4	Massage Room 1	9.9	80.0	4000	3000
5	Massage Room 2	9.9	80.0	4000	3000
6	Squash Court	3.5	17.5	5000	80

/* Q2: How many facilities do not charge a fee to members? */

SQL query: 
SELECT name FROM `Facilities` WHERE ( membercost =0 ) LIMIT 0 , 30;

name	
Badminton Court
Table Tennis
Snooker Table
Pool Table


/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SQL query: 
SELECT facid, name, membercost, monthlymaintenance 
FROM `Facilities` 
WHERE (membercost < 0.2*monthlymaintenance) LIMIT 0, 30 ;
Rows: 9

facid	name	membercost	monthlymaintenance	
0	Tennis Court 1	5.0	200
1	Tennis Court 2	5.0	200
2	Badminton Court	0.0	50
3	Table Tennis	0.0	10
4	Massage Room 1	9.9	3000
5	Massage Room 2	9.9	3000
6	Squash Court	3.5	80
7	Snooker Table	0.0	15
8	Pool Table	0.0	15


/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */

SQL query: 
SELECT * FROM `Facilities` WHERE facid in (1,5) LIMIT 0, 30 ;


facid	name	membercost	guestcost	initialoutlay	monthlymaintenance	
1	Tennis Court 2	5.0	25.0	8000	200
5	Massage Room 2	9.9	80.0	4000	3000


/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

SQL query: 
SELECT name, 
case when (monthlymaintenance > 100) 
then 'expensive' 
else 'cheap' end as cost 
FROM 'Facilities'

name	cost	
Tennis Court 1	expensive
Tennis Court 2	expensive
Badminton Court	cheap
Table Tennis	cheap
Massage Room 1	expensive
Massage Room 2	expensive
Squash Court	cheap
Snooker Table	cheap
Pool Table	cheap


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SQL query: 
SELECT surname, firstname , max(joindate) as last 
FROM `Members` ;

 This table does not contain a unique column. Grid edit, checkbox, Edit, Copy and Delete features are not available.
surname	firstname	last	
GUEST	GUEST	2012-09-26 18:08:45


/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT DISTINCT mems.surname AS member, facs.name AS facility
FROM  `Members` mems
JOIN  `Bookings` bks ON mems.memid = bks.memid
JOIN  `Facilities` facs ON bks.facid = facs.facid
WHERE bks.facid
IN ( 0, 1 ) 
ORDER BY member
LIMIT 0 , 30


member	facility	
Bader	Tennis Court 2
Bader	Tennis Court 1
Baker	Tennis Court 2
Baker	Tennis Court 1
Boothe	Tennis Court 2
Boothe	Tennis Court 1
Butters	Tennis Court 2
Butters	Tennis Court 1
Coplin	Tennis Court 1
Crumpet	Tennis Court 1
Dare	Tennis Court 2
Dare	Tennis Court 1
Farrell	Tennis Court 2
Farrell	Tennis Court 1
Genting	Tennis Court 1
GUEST	Tennis Court 2
GUEST	Tennis Court 1
Hunt	Tennis Court 2
Hunt	Tennis Court 1
Jones	Tennis Court 2
Jones	Tennis Court 1
Joplette	Tennis Court 2
Joplette	Tennis Court 1
Owen	Tennis Court 2
Owen	Tennis Court 1
Pinker	Tennis Court 1
Purview	Tennis Court 2
Rownam	Tennis Court 2
Rownam	Tennis Court 1
Rumney	Tennis Court 2




/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SQL query: 
SELECT mems.surname AS member, facs.name AS facility, 
CASE 
WHEN mems.memid =0
THEN bks.slots * facs.guestcost
ELSE bks.slots * facs.membercost
END AS cost
FROM  `Members` mems
JOIN  `Bookings` bks ON mems.memid = bks.memid
JOIN  `Facilities` facs ON bks.facid = facs.facid
WHERE bks.starttime >=  '2012-09-14'
AND bks.starttime <  '2012-09-15'
AND (
(
mems.memid =0
AND bks.slots * facs.guestcost >30
)
OR (
mems.memid !=0
AND bks.slots * facs.membercost >30
)
)
ORDER BY cost DESC 
LIMIT 0 , 1000


Rows: 12

member	facility	cost	
GUEST	Massage Room 2	320.0
GUEST	Massage Room 1	160.0
GUEST	Massage Room 1	160.0
GUEST	Massage Room 1	160.0
GUEST	Tennis Court 2	150.0
GUEST	Tennis Court 1	75.0
GUEST	Tennis Court 1	75.0
GUEST	Tennis Court 2	75.0
GUEST	Squash Court	70.0
Farrell	Massage Room 1	39.6
GUEST	Squash Court	35.0
GUEST	Squash Court	35.0


/* Q9: This time, produce the same result as in Q8, but using a subquery. */

SELECT member, facility, cost
FROM (

SELECT mems.surname AS member, facs.name AS facility, 
CASE 
WHEN mems.memid =0
THEN bks.slots * facs.guestcost
ELSE bks.slots * facs.membercost
END AS cost
FROM  `Members` mems
JOIN  `Bookings` bks ON mems.memid = bks.memid
INNER JOIN  `Facilities` facs ON bks.facid = facs.facid
WHERE bks.starttime >=  '2012-09-14'
AND bks.starttime <  '2012-09-15'
) AS bookings
WHERE cost >30
ORDER BY cost DESC

member	facility	cost	
GUEST	Massage Room 2	320.0
GUEST	Massage Room 1	160.0
GUEST	Massage Room 1	160.0
GUEST	Massage Room 1	160.0
GUEST	Tennis Court 2	150.0
GUEST	Tennis Court 2	75.0
GUEST	Tennis Court 1	75.0
GUEST	Tennis Court 1	75.0
GUEST	Squash Court	70.0
Farrell	Massage Room 1	39.6
GUEST	Squash Court	35.0
GUEST	Squash Court	35.0


/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */
SELECT name, totalrevenue
FROM (
SELECT facs.name, 
SUM(CASE WHEN memid =0 THEN slots * facs.guestcost ELSE slots * membercost END ) AS totalrevenue
FROM  `Bookings` bks
INNER JOIN  `Facilities` facs ON bks.facid = facs.facid
GROUP BY facs.name
) 
AS selected_facilities
WHERE totalrevenue <=1000
ORDER BY totalrevenue;


name	totalrevenue	
Table Tennis	180.0
Snooker Table	240.0
Pool Table	270.0
