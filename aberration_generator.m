function [aberrations] = aberration_generator(num_gen)
    aberrations = struct;
    slider_settings = .2:.2:2;
    for abit = 1:num_gen
        %num_gen = 1;
        ang = 10e-10;
        nm = 10e-9;
        um = 10e-6;
        mm = 10e-3;

        aberrations(abit).n =    [  1,   2,   2,   3,   3,   3,   4,   4,   4,   5, 5, 5, 5];
        aberrations(abit).m =    [  0,   1,   3,   0,   2,   4,   1,   3,   5,   0, 2, 4, 6];
        aberrations(abit).angle = 180*(2*rand(1,length(aberrations(abit).n)))./aberrations(abit).n; %zeros(1,length(aberrations(abit).n));%
        aberrations(abit).unit = [ang,  nm,  nm,  um,  um,  um,  mm,  mm,  mm,  mm,mm,mm,mm];
        %                    x , 157,95.5,10.4,10.4,5.22, 0.1,  xx,  xx,  10,10,10,10
        lims = [50, 157,95.5, 10.4, 10.4,5.22,0.1,0.5,0.5,10,10,10,10]; % Kirkland Ultramicroscopy 2011
        slider_pos = slider_settings(ceil(rand()*10));
        scaling = .5*rand();
        for it = 1:length(lims)
            ab_val = scaling*lims(it)*(rand()-.5);
            aberrations(abit).mag(it) = ab_val;
        end
    end
    
end