def read_image(filename)
    import struct
    file = open(filename,"rb")
	g = file.read()
	s = struct.unpack("I"*4g[0:16])
	cols, rows, slices, frames = s
	t = struct.unpack("f"*cols*rows*slices*frames,g[17:])
	return (s,t)
	
	
    