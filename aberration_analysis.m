function [] = aberration_analysis(aberration, ap_size)
    imdim = 256;
    simdim = 90;
    shifts = [0 0];
    perfect = aberration;
    perfect.mag(:) = 0;
    perfect.angle(:) = 0;
    %% Primary calculation
    [im, chi0, min_p4,probe, ~] = shifted_ronchigram(aberration,shifts,ap_size,imdim,simdim);
    [~, ~, ~, perf_probe, ~] = shifted_ronchigram(perfect,shifts,ap_size,imdim,simdim);
    %% Ronchigram
%     figure;
%     imagesc(im);
%     colormap gray;
%     axis equal off;
    %viscircles([128 128], 17.*256/90,'Color','red')
    
    %% Strehl ratio
%     [~, Ss] = strehl_calculator(aberration,imdim,simdim,.9,1);
%     figure;
%     plot(Ss);
%     title('Strehl Ratio versus Aperture Size');
%     xlabel('Aperture Size (mrad)');
%     ylabel('Strehl Ratio');
    
    %% Aberration function
%     figure;
%     imagesc(chi0);
%     axis equal off;
%     colormap inferno
%     title('Aberration function');
    
    %% Radially averaged aberration function
%     [Zr, ~] = radialavg(chi0,256, 0, 0);
%     figure;
%     plot((1:length(Zr)).*simdim/imdim,Zr);
%     title('Radially averaged aberration function');
%     xlabel('r');
%     ylabel('\chi(r)');

    %% Probe
    probe_max = max(probe(:))
    figure;
    square_dim = 24;
    lambda = 1.97e-12; % m
    px_size = lambda / (simdim.*1e-3)
    dims = (imdim-square_dim)/2:(imdim+square_dim)/2;
    
    imagesc(probe(dims,dims));
    colormap inferno;
    axis equal off;
    title(['Probe, FoV: ' num2str(square_dim*px_size) ' m'])
    
    %% Probe radial profile
    [Zr, ~] = radialavg(probe,128, 0, 0);
    Zr(1) = probe(129,129);
    [perf_Zr, ~] = radialavg(perf_probe,128,0,0);
    perf_Zr(1) = perf_probe(129,129);

    norm_Zr = Zr ./ perf_Zr(1);
    perf_Zr = perf_Zr ./ perf_Zr(1);
    extent = 25;
    figure;
    plot((0:extent-1).*px_size,norm_Zr(1:extent));
    hold on;
    plot((0:extent-1).*px_size,perf_Zr(1:extent));

    title('Probe Radial Profile');
    xlabel('r (m)');
    ylabel('Probe Intensity');


    
    
end