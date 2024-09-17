SELECT COUNT(firstname) OVER (), firstname, surname
FROM cd.members
ORDER BY joindate ASC
