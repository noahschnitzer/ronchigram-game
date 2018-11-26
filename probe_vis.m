function [] = probe_vis(fig,aberration, apertures,simdim, imdim )
    figure(fig);
    hold on;
    colors = {'red', 'cyan', 'blue','green','yellow'};
    leg = {};
    for ap_num = 1:length(apertures)
        aperture = apertures(ap_num);
        leg{end+1} = [num2str(aperture) ' Probe'];
        leg{end+1} = [num2str(aperture) ' Perfect'];

        perfect = aberration;
        perfect.mag(:) = 0;
        perfect.angle(:) = 0;
        shifts = [0 0];

        [~,~,~, probe1, ~] = shifted_ronchigram(aberration,shifts,aperture,imdim,simdim);
        [~,~,~, perf1 , ~] = shifted_ronchigram(perfect,shifts,aperture,imdim,simdim);
        lambda = 1.97e-12; % TODO
        px_size = lambda / (simdim.*1e-3);

        [Zr1, ~] = radialavg(probe1,imdim/2, 0, 0);
        Zr1(1) = probe1(129,129);
        [perf_Zr1, ~] = radialavg(perf1,imdim/2,0,0);
        perf_Zr1(1) = perf1(imdim/2+1,imdim/2+1);

        norm_Zr1 = Zr1 ./ perf_Zr1(1);
        perf_Zr1 = perf_Zr1 ./ perf_Zr1(1);

        extent = 15;
        xrange = (0:extent-1).*px_size;
        subplot(121);
        hold on;
        plot(xrange,norm_Zr1(1:extent),'LineWidth',2,'Color',colors{ap_num});
        hold on;
        plot(xrange,perf_Zr1(1:extent),'LineWidth',1,'Color',colors{ap_num});
        
        subplot(122);
        plot(xrange,cumsum(norm_Zr1(1:extent)),'LineWidth',2,'Color',colors{ap_num});
        hold on;
        plot(xrange,cumsum(perf_Zr1(1:extent)),'LineWidth',1,'Color',colors{ap_num});
        
    end
    subplot(121);
    legend(leg)
    title('Probe Radial Profile');
    xlabel('r (m)');
    ylabel('Probe Intensity');
    subplot(122);
    title('Probe Cumulative Radial Profile');
    xlabel('r (m)');
    ylabel('Probe Cumulative Intensity');

end
