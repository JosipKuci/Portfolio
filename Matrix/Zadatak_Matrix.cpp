#include<graphics.h>
#include<string>
#include<iostream>
using namespace std;
int main()
{
	initwindow(600,600);
	int x,y,xx,yy,i=0,r;
	x=getmaxx();
	y=getmaxy();
	setbkcolor(0);
	setcolor(GREEN);
	cleardevice();
	while(!kbhit())
	{
		settextstyle(0,HORIZ_DIR,1);
		int xx=rand()%x;
		for(int yy=0;yy<=rand()%601+300;yy+=10)
		{
		int asci=rand()%94+33;
	    char ch={asci};
	    char* ch1=&ch;	
		outtextxy(xx,yy,ch1);
		delay(25);
		memset(ch1, 0, sizeof ch1);			
		}
		int xx2=rand()%x;
		for(int yy=0;yy<=rand()%601+300;yy+=10)
		{
		int asci=rand()%94+33;
	    char ch={asci};
	    char* ch1=&ch;	
		outtextxy(xx2,yy,ch1);
		memset(ch1, 0, sizeof ch1);	
		delay(25);			
		}
	}
	getch();
	return 0;
}
