dir_codes=pwd;

for mouse = [1 2 3 4 5 6]
    for dl = 2.5
        for NS = [5:5:50]
            ShIRToutputmap_code(mouse,18,dl,NS)
            cd(dir_codes)
        end
    end
end