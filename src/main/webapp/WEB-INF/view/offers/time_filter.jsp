<!-- time_filter.jsp -->
<!DOCTYPE html>
<html>
<head>
    <title>Export Offers</title>
</head>
<body>
<h1>Export Offers</h1>
<form action="filterOffers" method="get">
    <label for="startDate">Start Date:</label>
    <input type="date" id="startDate" name="startDate" required>
    <label for="endDate">End Date:</label>
    <input type="date" id="endDate" name="endDate" required>
    <button type="submit">Filter Offers</button>
</form>
</body>
</html>
