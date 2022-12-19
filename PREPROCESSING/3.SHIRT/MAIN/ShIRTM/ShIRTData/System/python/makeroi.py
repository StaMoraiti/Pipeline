from tkinter import *

import sys

root = Tk()

#fl = sys.argv[1]
fl = "c:/ShIRTMV7/Displays/bitmap"
file = open(fl + ".txt","r")
txt = file.read()
file.close()
start, sep, end = txt.partition(" ")
start = int(start)
end = int(end)
#ofl = sys.argv[2]
ofl = "c:/ShIRTMV7/Displays/roi"
roinum = 1


#file = sys.argv[1]
#file = "c:/ShIRTMV7/Displays/bitmap"


def get_int(g):
    """ convert bytes to integer """
    return (((g[3]*256+g[2])*256+g[1])*256+g[0])

def get_short(g):
    """ convert bytes to short """
    return (g[1]*256+g[0])

def plt(col):
    f = "#%02x%02x%02x" % col
    return f

def load_bmp(file):
    file = open(file+'.bmp','rb')
    buf = file.read(54)
    g = list(buf)
    cols = get_int(g[18:22])
    rows = get_int(g[22:26])
    bitsperpix = get_short(g[28:30])
    colours = get_int(g[46:50])
    im = list(file.read(cols*rows*3))
    file.close()
    np = cols*rows
    blue = im[0:np*3:3]
    green = im[1:np*3:3]
    red = im[2:np*3:3]
    col = list(zip(red, green, blue))
    m = list(map(plt,col))
    m[0] = "{"+m[0]
    row = 1
    while row < rows:
       m[row*cols] = "{"+m[row*cols]
       m[row*cols-1] = m[row*cols-1]+"}"
       row = row+1
    m[rows*cols-1] = m[rows*cols-1]+"}"
    m = " ".join(m)
    return (cols, rows, m)

def new_image(event):
    global x, y, w1,w2,photo
    num = w1.get()
    cols,rows,m = load_bmp("c://ShIRTMV7/Displays/bitmap"+str(num))
    photo.put(m)
    canvas.create_image(0,0, anchor="nw",image=photo)

def draw_line(event):
    global roi, canvas
    x2, y2 = (event.x), (event.y)
    roi = roi + [[x2, y2]]
    ln = len(roi)
    if ln > 1:
        x1,y1 = roi[ln-2]
        x2,y2 = roi[ln-1]
        canvas.create_line(x1,y1,x2,y2,fill="#ffffff", width=2)
    else:
        canvas.create_oval(x2-2,y2-2,x2+2,y2+2,fill="#ffffff");

def make_roi(event):
    global roi, ofl, canvas, roinum
    ofile = open(ofl + str(roinum) + '.txt',"w")
    ln = len(roi)
    roi = roi + [roi[0]]
    canvas.create_line(roi[ln-1][0],roi[ln-1][1],roi[ln][0],roi[ln][1],fill="#ffffff", width=2)
    count = 0
    ln = len(roi)
    while count < ln:
        ofile.write("{" + str(roi[count][0]) + " " + str(roi[count][1]) + "} ")
        count = count + 1
    ofile.close()
    ofile = open(ofl + 'num.txt',"w")
    ofile.write(str(roinum))
    ofile.close()
    roinum = roinum + 1
    roi = []
    

middle = int((end+start)/2)
cols, rows, m = load_bmp(fl+str(middle))
canvas_width = cols
canvas_height = rows
roi = []

canvas = Canvas(root, 
           width=canvas_width, 
           height=canvas_height)
photo = PhotoImage()
photo.put(m)

canvas.create_image(0,0, anchor=NW, image=photo)
canvas.grid(column=0,row=0)
canvas.bind("<Button-1>",draw_line)
canvas.bind("<Button-3>",make_roi)


root.mainloop()
