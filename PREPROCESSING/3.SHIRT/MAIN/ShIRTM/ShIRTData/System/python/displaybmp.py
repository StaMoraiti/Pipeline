from tkinter import *

import sys

root = Tk()

#file = sys.argv[1]
file = open("c:/ShIRTMV7/Displays/bitmap.txt","r")
txt = file.read()
start, sep, end = txt.partition(" ")
start = int(start)
end = int(end)

file = "c:/ShIRTMV7/Displays/bitmap"

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


middle = int((end+start)/2)
cols, rows, m = load_bmp(file+str(middle))
canvas_width = cols
canvas_height = rows
root.title(file)
canvas = Canvas(root, 
           width=canvas_width, 
           height=canvas_height)
photo = PhotoImage()
photo.put(m)

canvas.create_image(0,0, anchor=NW, image=photo)
canvas.grid(column=0,row=0)
if end-start+1 > 1:
    w1 = Scale(root, from_=1, to=end, orient=HORIZONTAL, length=cols)
    w1.grid(column= 0, row= 1)
    w1.set(middle)
    w1.bind("<B1-Motion>",new_image)

root.mainloop()
