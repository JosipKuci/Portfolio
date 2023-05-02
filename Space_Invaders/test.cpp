#include<cstring>
#include<iostream>
#include<fstream>
#include<graphics.h>
#include<Windows.h>
using namespace std;
void upute()
{
	cleardevice();
	bool klik1=0;
	settextstyle(0,0,3);
	outtextxy(20,50,"UPUTSTVA");
	settextstyle(0,0,1);
	outtextxy(20,100,"Bit igre je unistiti sve neprijateljske brodove");
	outtextxy(20,120,"Prijateljski svemirski brod se krece strijelicama");
	outtextxy(20,140,"lijevo-desno na tipkovnici te puca sa tipkom <SPACE>");
	outtextxy(20,160,"Legenda neprijatelja:");
	setfillstyle(1,1);
	bar(60,180,80,200);
	setfillstyle(1,12);
	bar(100,180,120,200);
	setfillstyle(1,14);
	bar(140,180,160,200);
	setfillstyle(1,13);
	bar(180,180,200,200);
	setfillstyle(1,WHITE);
	bar(0,570,200,640);
	outtextxy(15,600,"Natrag na main menu");
z:	while(!kbhit() and klik1!=1)
	{
		klik1=0;
		if (ismouseclick(WM_LBUTTONDOWN) and mousex()>=0 and mousey()>=570 and mousex()<=200 and mousey()<=640)
		{
			klik1=1;
			clearmouseclick(WM_LBUTTONDOWN);
		}
		if(kbhit())
		{
			getch();
			goto z;
		}
	}
}
void mainmenu()
{
u:  cleardevice();
	bool klik=0;
	settextstyle(0,0,3);
	setcolor(GREEN);
	outtextxy(100,100,"SPACE INVADERS");
	setcolor(WHITE);
	setfillstyle(1,WHITE);
	bar(150,200,370,250);
	settextstyle(0,0,2);
	outtextxy(10,600,"Zasluge: Josip Šimun Kuèi 2TR2");
	outtextxy(165,215,"Pokreni igru");
	bar(150,300,370,350);
	outtextxy(165,315,"Upute igre");
v:	while(!kbhit() and klik!=1)
	{
		klik=0;
		
		if (ismouseclick(WM_LBUTTONDOWN) and mousex()>=150 and mousey()>=200 and mousex()<=320 and mousey()<=250)
		{
			klik=1;
			clearmouseclick(WM_LBUTTONDOWN);
		}
		else if(ismouseclick(WM_LBUTTONDOWN) and mousex()>=150 and mousey()>=300 and mousex()<=320 and mousey()<=370)
		{
			klik=1;
			clearmouseclick(WM_LBUTTONDOWN);
			upute();
			klik=0;
			goto u;
		}
		if(kbhit())
		{
			getch();
			goto v;
		}
	}
}

void pocetak()
{
	cleardevice();
	settextstyle(0,0,2);
	outtextxy(200,320,"Spremni?");
	delay(2000);
	cleardevice();
	outtextxy(200,320,"START!");
	delay(2000);
}
int crtanje_broda(int x, int y)
{
	setfillstyle(1,GREEN);
	bar(x-15,y-10,x+15,y+5);
	bar(x-3,y-20,x+3,y-10);
	setfillstyle(1, WHITE);
}

int unos(int x)
{
	if(GetAsyncKeyState(VK_LEFT))
	{
		x-=2;
	}
	else if(GetAsyncKeyState(VK_RIGHT))
	{
		x+=2;
	}
	if(x>520)
	{
		x=520;
	}
	if(x<0)
	{
		x=0;
	}
	return x;
}
int score(int bodovi)
{
	setcolor(WHITE);
	stringstream ss1;
    ss1<<bodovi;
	string str1=ss1.str();
    char *cstr1 = new char[str1.length() + 1];
    strcpy(cstr1, str1.c_str());
    settextstyle(3,0,2);
    outtextxy(25,20,"SCORE");
	outtextxy(50,50,cstr1);
	delete [] cstr1; 
}
int hscore(int highscore)
{
	setcolor(WHITE);
	stringstream ss2;
    ss2<<highscore;
	string str2=ss2.str();
    char *cstr2 = new char[str2.length() + 1];
    strcpy(cstr2, str2.c_str());
    settextstyle(3,0,2);
    outtextxy(370,20,"HIGH SCORE");
	outtextxy(420,50,cstr2);
	delete [] cstr2;
}
int main()
{
	initwindow(520,640,"Space Invaders");
	setbkcolor(BLACK);
	setcolor(GREEN);
	cleardevice();
	ifstream ulaz("highscore.txt");
	fstream izlaz;
	c:	mainmenu();
	int bod, bodovi=0, highscore;
	int runda=1;
	ulaz>>highscore;
	ulaz.close();
	int n_zivota=3, brojac=1;
	bool gameover=0;
	int x_hitac, y_hitac, x_hitac_zlikovac, y_hitac_zlikovac;
o:	int x=getmaxx()/2;
	int y=550;
	float brzina_zlikovca=0.2+(runda*0.1);
	bool stanje[52]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},zlikovac[52]={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};
	int broj_unistenih_zlikovaca=0;
	bool hitac=0;
	int timer=1, brojac_timera=0;
	bool stanje_hitca_zlikovca=0;
	int zlikovci_y[52]={100,100,100,100,100,100,100,100,100,100,100,100,100,180,180,180,180,180,180,180,180,180,180,180,180,180,260,260,260,260,260,260,260,260,260,260,260,260,260,340,340,340,340,340,340,340,340,340,340,340,340,340};
	float zlikovci_x[52]={20,60,100,140,180,220,260,300,340,380,420,460,500,20,60,100,140,180,220,260,300,340,380,420,460,500,20,60,100,140,180,220,260,300,340,380,420,460,500,20,60,100,140,180,220,260,300,340,380,420,460,500};
	pocetak();
	while(!GetAsyncKeyState('K') and  gameover!=1)
	{
		cleardevice();
		score(bodovi);
		hscore(highscore);
		crtanje_broda(x,y);
		for(int i=0;i<52;i++)
		{
		 if(zlikovac[i]==1)
		 {
		 	if(i<13)
		    {
		    	setfillstyle(1,1);
		    	goto p;
			}
			else if(i<26)
			{
				setfillstyle(1,12);
				goto p;
			}
			else if(i<39)
			{
				setfillstyle(1,14);
				goto p;
			}
			else 
			{
				setfillstyle(1,13);
				goto p;
			}
p:		 bar(zlikovci_x[i]-15,zlikovci_y[i]-15,zlikovci_x[i]+15,zlikovci_y[i]+15);			
		 if(zlikovci_x[i]<=500 && stanje[i]==0)
		 {
			zlikovci_x[i]+=brzina_zlikovca;
		 }
		 else if(stanje[i]==1)
		 {
			zlikovci_x[i]-=brzina_zlikovca;
		 }
		 if(zlikovci_x[i]>=500 && stanje[i]==0)
		 {
			stanje[i]=1;
			zlikovci_y[i]+=40;
		 }
		 else if(zlikovci_x[i]<=20 && stanje[i]==1)
		 {
			stanje[i]=0;
			zlikovci_y[i]+=40;
		 }
		}
	   }
	   for(int j=20;brojac<=n_zivota;j+=40)
	   {
	   	   setcolor(GREEN);
	   	   setfillstyle(1,GREEN);
	   	   bar(j-10,600,j+10,610);
	   	   brojac++;
	   	   setfillstyle(1,WHITE);
	   }
	   brojac=1;
		if(GetAsyncKeyState(VK_SPACE) && hitac==0)
		{
			hitac=1;
			x_hitac=x;
			y_hitac=y-10;
		}
		if(hitac==1)
		{
			bar(x_hitac-2,y_hitac-5,x_hitac+2,y_hitac+5);
			y_hitac-=12;
		}
		if(y_hitac<=0)
		{
			hitac=0;
			for(int j=1;j<15;j++)
			{
				circle(x_hitac,y_hitac,j);
		    }
		}
		for(int i=0;i<52;i++)
		{
		 if(y_hitac<=(zlikovci_y[i]+15) and x_hitac<=(zlikovci_x[i]+15) and y_hitac>=(zlikovci_y[i]-15) and x_hitac>=(zlikovci_x[i]-15) and hitac==1)
		 {
			hitac=0;
			zlikovac[i]=0;
			broj_unistenih_zlikovaca++;
			if(i<13)
		    {
		    	bod=40;
		    	goto k;
			}
			else if(i<26)
			{
				bod=30;
				goto k;
			}
			else if(i<39)
			{
				bod=20;
				goto k;
			}
			else 
			{
				bod=10;
				goto k;
			}
k:			bodovi+=bod;
            if(bodovi>highscore)
            {
            	highscore=bodovi;
            	izlaz.open("highscore.txt",ios::out);
            	izlaz<<highscore;
            	izlaz.close();
			}
			for(int j=1;j<25;j++)
			{
				settextstyle(0,0,1);
				setcolor(YELLOW);
				circle(zlikovci_x[i],zlikovci_y[i],j);
				delay(7);
				setcolor(WHITE);
				stringstream ss;
		        ss<<bod;
		        string str=ss.str();
                char *cstr = new char[str.length() + 1];
                strcpy(cstr, str.c_str());
			    outtextxy(zlikovci_x[i]-10,zlikovci_y[i]-10,cstr);
			    delete [] cstr; 
			}
			zlikovci_x[i]=1000;
			zlikovci_y[i]=1000;
			brzina_zlikovca+=0.07;
			y_hitac=640;
			x_hitac=700;
			if(broj_unistenih_zlikovaca>=52)
			{
				runda++;
				goto o;
			}
		 }
		 if(zlikovci_x[i]>=(x-15) && zlikovci_y[i]>=(y-10) && zlikovci_x[i]<=(x+15) && zlikovci_y[i]<=(y+5))
		 {
		 	for(int j=1;j<=30;j++)
			{
				delay(25);
				setcolor(WHITE);
				circle(x,y,j);
			}
		 	gameover=1;
		 }
		}
		if(brojac_timera==timer)
		{
			int random=rand()%52;
l:			if(zlikovac[random]==1 && stanje_hitca_zlikovca==0)
			{
			x_hitac_zlikovac=zlikovci_x[random];
			y_hitac_zlikovac=zlikovci_y[random];
			stanje_hitca_zlikovca=1;
			}
			else if (stanje_hitca_zlikovca==0)
			{
				random++;
				if(random>52)
				{
					random=0;
				}
				goto l;
			}
		}
		if(y_hitac_zlikovac<=(y+5) and x_hitac_zlikovac<=(x+15) and y_hitac_zlikovac>=(y-10) and x_hitac_zlikovac>=(x-15) and stanje_hitca_zlikovca==1)
		{
			for(int j=1;j<=30;j++)
			{
				delay(25);
				setcolor(WHITE);
				circle(x,y,j);
			}
			delay(30);
			x=getmaxx()/2;
			y=550;
			n_zivota--;
			if(n_zivota<1)
			{
				gameover=1;
			}
			stanje_hitca_zlikovca=0;
		}
		if(y_hitac_zlikovac>=640)
		{
			stanje_hitca_zlikovca=0;
		}
		if(stanje_hitca_zlikovca==1)
		{
			bar(x_hitac_zlikovac-2,y_hitac_zlikovac-5,x_hitac_zlikovac+2,y_hitac_zlikovac+5);
			y_hitac_zlikovac+=8;
		}
		if(brojac_timera==52)
		{
			brojac_timera=0;
		}
		x=unos(x);
		brojac_timera++;
		delay(15);
	}
	cleardevice();
	while(!GetAsyncKeyState('R'))
	{
		setcolor(GREEN);
		settextstyle(0,0,2);
		outtextxy(200,320,"GAME OVER");
		settextstyle(0,0,1);
		outtextxy(100,340,"pritisnite gumb R za povratak u main menu");
		getch();
	}
	goto c;
	return 0;
}
