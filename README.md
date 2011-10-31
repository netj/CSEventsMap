Computer Science Academic Events Map
====================================

Jaeho Shin <netj@stanford.edu>

It is hard to imagine there are people who pick their venue for publishing
primarily by where it is held instead of the impact factor or other metrics.
However, there are many researchers who mention the opportunities to travel
around the world by attending conferences and workshops as a big privilege of
academic jobs.  Moreover, I became aware of an interesting culture about IEEE
Symposia on VLSI Technology and Circuits.  They have been helding the event in
Hawaii, USA and Kyoto, Japan for every other years, and a friend of mine told
me there's a culture submitting to Hawaii first and then retrying to Kyoto next
year when they get rejected.  It would be great if my visualization can help
people to discover interesting facts from bibliographical data other than all
boring citation links, co-authorships, etc...

The data mainly comes from [The DBLP Computer Science Bibliography][dblp] for
past ones and from [Confy, My Computer Science Conference Agent][confy] for the
upcoming ones.  The goal of my visualization is to let computer science
researchers to see where their events are held around the world, and hopefully
provide them another criterion for choosing venues to publish or attend.  There
are about 12k records from them that have location and date information I could
extract from them.  More data from other sources, e.g. [IEEE Conference
Calendar][] or [ACM Events][], should be taken into account to provide more
complete picture.  However, due to the excessive amount of effort required for
incorporating data from them, and for the scope of this assignment, I think it
is fine to proceed with DBLP and Confy.

[dblp]: http://www.informatik.uni-trier.de/~ley/db/
[confy]: http://www.st.ewi.tudelft.nl/~mathijs/conf/
[ieee conference calendar]: http://www.computer.org/portal/web/conferences/calendar 
[acm events]: http://campus.acm.org/calendar/event_listing.cfm


Storyboard
----------

Here's the storyboard of my CS Events Map:

 1. User will see three screens: a map, a yearly stats with a slider, and a list of conferences and workshops that are shown in them.

 <img src="A3-ShinJaeho-storyboard-1-overview.png">

 2. User can select a region in the map to zoom in.

 <img src="A3-ShinJaeho-storyboard-2-mapzoom.png">

 It will give users detail-on-demand, updating other views with only the events held or to be held in that geographical region.

 <img src="A3-ShinJaeho-storyboard-3-mapzoomresult.png">

 3. Year range slider will allow user to limit the events based on when it was held.

 <img src="A3-ShinJaeho-storyboard-4-yearslider.png">

 4. By clicking on the list the user will be able to open the actual webpage which shows the program of the event or the homepage for submission and registration.

 <img src="A3-ShinJaeho-storyboard-5-listclick.png">



2. Implement your design.

(let's record timing!)

10/24 22:00- 10/25 4:30 (6h30m)
data extraction
dblp.xml
from proceedings[@key="conf/.*"]/title
 * venue, month day1-day2, year
 * venue, day1-day2 month year
 * month, year, venue
 * day1-day2 month year, venue
 * venue, month day1-month day2, year

10/25 dblp, confy extraction XSLT (6h)

10/26~27 dblp location name extraction 1:00 ~ 7:00 = (6h)

10/27 Geocoding, Tableau 16:00 ~ 18:00 (2h)
Geocoding >2 : 2011-10-27Thu22:17:22 ~ 2011-10-27Thu22:22:21  (5mins)
Geocoding =1 : 2011-10-27Thu23:35:39 ~ 2011-10-27Thu23:44:18  (10mins)


DBLP XML API? 
http://dblp.uni-trier.de/xml/docu/dblpxmlreq.pdf
http://dblp.uni-trier.de/rec/bibtex/conf/sas/2005.xml
http://dblp.uni-trier.de/search/author?xauthor=kwang+yi
http://dblp.uni-trier.de/rec/pers/y/Yi:Kwangkeun/xk



3. Produce a final writeup.
Your final submission should include:
The description with storyboards from part 1.
A brief description of your final interactive visualization application.
An explanation of changes between the storyboard and the final implementation.
The bundled source code for your application, uploaded as a file (either a .zip or .tar.gz archive) linked to your assignment wiki page. Please ensure that the software submitted is in working order. If any special instructions are needed for building or running your software, please include them in a text file within your archive.
For submissions by groups of two, please also include a breakdown of how the work was split among the group members.
Finally, please include a commentary on the development process, including answers to the following questions: Roughly how much time did you spend developing your application? What aspects took the most time?



== Interesting Findings ==

 * UbiComp 2010: Ubiquitous Computing, 12th International Conference,
   UbiComp 2010, Copenhagen, Denmark, September 26-29, 2019,
   Proceedings. ACM International Conference Proceeding Series ACM
   2010, ISBN 978-1-60558-843-8  http://dblp.uni-trier.de/db/conf/huc/ubicomp2010.html

 * Process in Distributed Operating Systems and Distributed Systems
   Management, European Workshop, Berlin, Germany, April 18-19, 1889
   1990  http://dblp.uni-trier.de/db/conf/pdos/pdos1989.html

 * 16th Euromicro Conference on Real-Time Systems (ECRTS 2004), 30
   June - 2 July 1004, Catania, Italy, Proceedings. IEEE Computer
   Society 2004, ISBN 0-7695-2176-2  http://dblp.uni-trier.de/db/conf/ecrts/ecrts2004.html

