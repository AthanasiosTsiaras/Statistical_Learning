Why invest in Lebanese Restaurants in Toronto?
========================================================
author: Athanasios Tsiaras
date: 11-18-2018
autosize: true

Business Problem
========================================================

The world-famous Lebanese food chain Lebana-Food want to expand their business in Toronto, Canada.  
From this project it is inferred that there are not many Lebanese places to eat in Canada,  
so this seems like a great opportunity for the company.  

However, they most important think that their CEO wants to know is where are the most restaurants in Toronto,
and especially those that are the most competing kinds like Chinese, Indian, Greek and Italian  
It is of great importance to the upper-management to know exactly where the competing restaurants are,
so they can decide where to open the new Lebanese places.  

A business research like this one can be very interesting for entrepreneurs in the restaurant business  
that want to know about popular restaurants on specific neighborhoods 

Getting and Cleaning the Data
========================================================

Data obtained through the Foursquare. API, with personal account credentials.
Before the methodology was applied to the data, the data had to be cleaned.  

The Foursquare.API contains many information, but not all of them are useful for this . 
particular project, nor they are downloaded on an easy to handle type. 

So, the unnecessary columns  
were discarded, and the useful information were inserted in Pandas data frames that are useful for analysis.



Methodology
========================================================

In order to solve the problem the data four queries were made and four dataframes were created, one for each type of competing restaurant.    
Each dataset has important information about individual restaurants of each kind, as well  
as geospatial information, necessary to visualize them.

By making a visualization of the map of Toronto that contains marks about every type of competing restaurant and are colored accordingly,  
the management of the Lebanese foodchain had powerful information at hand, that will help on future decision-making.

In addition to that, using again data from Foursquare, data about the most common type of shop in each neighborhood were obtained.  
This is going to be very helpful in determining not only what other restaurants are there, but also what other kinds of shops are popular  
in the area

Results
========================================================
The results were very encouraging for the company as, not only there no Lebanese Restaurants in Toronto, only Lebanese fast-food joints,  
but also there are neighborhoods with great investement potential.


Thank you!
========================================================
