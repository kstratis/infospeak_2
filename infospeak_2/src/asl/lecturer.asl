//An InfoSpeak lecturer - ABS assignments 2011/12
/* Initial beliefs */
//All generated by environment

/* Initial goal */

!start.
/* Plans */

+!start <- .my_name(Me); !checkevents(Me).

+!checkevents(Me): week(WeekNow) & day(DayNow) & time(TimeNow) <- .wait(1000); .findall(event(Name,Week,Day,Time,Place,Priority),event(Name,Week,Day,Time,Place,Priority)& (Week==0 | Week ==WeekNow) & Day == DayNow & Time == TimeNow,L); !pickaction(Me,L,WeekNow,DayNow,TimeNow).

+!pickaction(Me,L,WeekNow,Day,Time): .length(L) == 0 <- !givelectures(Me).
+!pickaction(Me,L,WeekNow,Day,Time): lecture(Name,Week,Day,Time,Place,Priority) &(Week == WeekNow | Week == 0) <- .concat(L,[lecture(Name,Week,Day,Time,Place,Priority)],M); ia.highest(M,X);!doaction(Me,X).
+!pickaction(Me,L,WeekNow,Day,Time) <- ia.highest(L,X);!doaction(Me,X).

+!doaction(Me,L): .nth(0,L,Type) & .nth(1,L,Name) & .nth(4,L,Time) & .nth(5,L,Place) & pos(Place,X,Y) & not pos(Me,X,Y)<- .concat("Going to ",Name," ",Type,".",G); add_goal(G); !goto(Me,X,Y); .concat("Attending ",Name," ",Type,".",H); add_goal(H); one_hour(Time); !checkevents(Me).
+!doaction(Me,L): .nth(0,L,Type) & .nth(1,L,Name) & .nth(4,L,Time) & .nth(5,L,Place) & pos(Place,X,Y) & pos(Me,X,Y)<- .concat("Attending ",Name," ",Type,".",H); add_goal(H); one_hour(Time); !checkevents(Me).

+!givelectures(Me) : week(WeekNow) & day(Day) & time(Time) & Time > 17 <- !gohome(Me); !sleep(Me).
+!givelectures(Me) : week(WeekNow) & day(Day) & time(TimeNow) & pos(Place,X,Y) & lecture(Name, Week, Day, Time, Place,Priority)  & Time == TimeNow & (Week ==0 | Week==WeekNow)<- add_goal("Going to the next lecture");!goto(Me,X,Y); .concat("Attending ", Name, " lecture",G);add_goal(G); one_hour(Time);!checkevents(Me).
+!givelectures(Me) : week(WeekNow) & day(Day) & time(Time) & Time == 12 & not (lecture(Name,Week,Day, Time, Place,Priority) & Week == 0 | Week == WeekNow)<- !gotorestaurant(Me); add_goal("Having lunch"); !checkevents(Me).
+!givelectures(Me) : week(WeekNow) & day(Day) & time(Time) & not (lecture(Name,Week,Day, Time, Place,Priority) & Week == 0 | Week == WeekNow) & Time > 9 & Time <= 17<- !gotoforum(Me); add_goal("Working in forum.");!checkevents(Me).
+!givelectures(Me) : week(WeekNow) & day(Day) & time(Time) & pos(Place,X,Y) & not (lecture(Name,Week,Day, Time, Place,Priority) & Week == 0 | Week == WeekNow)  <- !checkevents(Me).
+!givelectures(Me) <- !givelectures(Me). 

+!gotoforum(Me): pos(frum1,X,Y) & pos(Me,Xm,Ym) & X == Xm & Y == Ym.
+!gotoforum(Me): pos(frum1,X,Y) <- add_goal("Going to forum!"); !goto(Me,X,Y).

+!gotorestaurant(Me): pos(rest1,X,Y) & pos(Me,Xm,Ym) & X == Xm & Y == Ym.
+!gotorestaurant(Me): pos(rest1,X,Y) <- add_goal("Going to restaurant!"); !goto(Me,X,Y).

+!gohome(Me): home(H) & pos(H,X,Y) & pos(Me,Xm,Ym) & not(X == Xm & Y == Ym) <- add_goal("Day over, going home."); !goto(Me,X,Y).
+!gohome(Me): home(H) & pos(H,X,Y) & pos(Me,Xm,Ym) & X == Xm & Y == Ym <- .print("Just arrived HOME").

+!sleep(Me) <- add_goal("Sleeping."); !checkevents(Me).

+!goto(Me,X,Y) : not pos(Me,X,Y) <- .print("travelling"); go_to(X,Y).


/*
 * +!goto(Me,X,Y) : pos(Me,X,Y) <- .print("Just arrived").
 *
 *
 * +!goto(Me,X,Y) : pos(Me,X,Y).
 * 
 */
 
 