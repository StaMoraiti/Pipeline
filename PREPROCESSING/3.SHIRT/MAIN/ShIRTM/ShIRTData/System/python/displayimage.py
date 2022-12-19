from tkinter import *

import sys


file = sys.argv[1]


def plt(col):
    f = "#%02x%02x%02x" % col
    return f

def read_image(filename):
    import struct
    file = open(filename+ ".image","rb")
    g = file.read()
    s = struct.unpack("I"*4,g[0:16])
    cols, rows, slices, frames = s
    t = struct.unpack("f"*cols*rows*slices*frames,g[16:])
    return (s,t)

def limitrange(t):
    if t > 255:
        t = 255
    if t < 0:
        t = 0
    return t

def convert_image(lower,upper):
    """ convert to a display format"""
    global im
    s,t = im
    cols = s[0]
    rows = s[1]
    mx = max(t)
    lw = mx*lower/100
    up = mx*upper/100
    t = [int((x-lw)*255/(up-lw)) for x in list(t)]
    t = [limitrange(x) for x in t]
    np = cols*rows
    blue = t
    green = t
    red = t
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
    return m

def new_image(event):
    global x, y, w1,w2,img
    upper = w2.get()
    lower = w1.get()
    m = convert_image(lower,upper)
    img.put(m)
    canvas.create_image(0,0, anchor="nw",image=img)
    
root = Tk()
root.title(file)
im = read_image(file)
cols = im[0][0]
rows = im[0][1]

upper = 100
lower = 0

print(cols,rows)
x = int(512/cols)
y = x

canvas_width = cols
canvas_height = rows

canvas = Canvas(root, 
           width=canvas_width, 
           height=canvas_height)
canvas.grid(column=0,row=0)

img = PhotoImage()
img.put(convert_image(lower,upper))
print(img)

w1 = Scale(root, from_=0, to=100, orient=VERTICAL, length=cols)
lower = w1.get()
w1.bind("<B1-Motion>",new_image)
w1.set(0)
w1.grid(column= 1, row= 0)
w2 = Scale(root, from_=0, to=100, orient=VERTICAL, length=cols)
upper = w2.get()
w2.set(100)
w2.bind("<B1-Motion>",new_image)
w2.grid(column=2,row=0)
upper = w2.get()
lower = w1.get()
canvas.create_image(0,0, anchor=NW, image=img)
mainloop()
  


