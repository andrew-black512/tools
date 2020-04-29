=head 1

Topic: St John's East Dulwich's Coffee Morning
Time: Apr 29, 2020 11:00 AM London

Join Zoom Meeting
https://us02web.zoom.us/j/87048507656

Meeting ID: 870 4850 7656

-cut


while (<>)
{
    if ( /Topic:|Time:/ ) {
    	print;
    	next;
    }
}