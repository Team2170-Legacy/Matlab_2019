Rocket_line_start.x = 6;
Rocket_line_start.y = 0;
Rocket_line_end.x = Rocket_line_start.x;
Rocket_line_end.y = 18 * in;

plot([Rocket_line_start.x, Rocket_line_end.x] , [Rocket_line_start.y, Rocket_line_end.y] , 'red')



Rocket_line_start1.x = 8;
Rocket_line_start1.y = 0;
Rocket_line_end1.x = Rocket_line_start1.x;
Rocket_line_end1.y = 18 * in;

plot([Rocket_line_start1.x, Rocket_line_end1.x] , [Rocket_line_start1.y, Rocket_line_end1.y] , 'blue')

Target.x = Rocket_line_start.x;
Target.y = Robot.W/2;
%Robot.theta = 180 * deg;