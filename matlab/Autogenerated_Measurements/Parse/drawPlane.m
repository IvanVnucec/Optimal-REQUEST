function drawPlane(qib)

    % Faktor prozirnosti tijela
    p = 0.5;

    % Tocke zrakoplova u koordinatnom sustavu tijela
    P1 = [-4,-4,0]';
    P2 = [-4,-0.5,0]';
    P3 = [-4,0,-1.5]';
    P4 = [P2(1),-P2(2),P2(3)]';
    P5 = [P1(1),-P1(2),P1(3)]';
    P6 = [8,0,0]';

    % Skaliranje i spremanje tocaka tijela u stupce matrice Pb
    Pb = 0.2*[P1,P2,P3,P4,P5,P6];

    % ---------------------------------------------------------------------
    % Trazenje tocaka u inercijalnom koordinatnom sustavu
    % ---------------------------------------------------------------------
    
    % Iz kvaterniona racunam rotacijsku matricu I->B
    Rib = qib2Rib(qib);
    
    % Izracun rotacijske matrice B->I (obicna transpozicija)
    Rbi = Rib';
    
    % Trazenje reprezentacije pojedine tocke zrakoplova u inercijalnom
    % sustavu i spremanje njezinih koordinata u stupce matrice Pi
    Pi = Rbi*Pb;
    
    % Kreiranje koordinata stranica tijela iz rotiranih tocaka
    LW = [Pi(:,1) Pi(:,2) Pi(:,6)]; % Left Wing
    RW = [Pi(:,4) Pi(:,5) Pi(:,6)]; % Right Wing
    LS = [Pi(:,2) Pi(:,3) Pi(:,6)]; % Left Side
    RS = [Pi(:,3) Pi(:,4) Pi(:,6)]; % Right Side
    
    % Brisanje prikaza na slici
    clf;
    
    % Crtanje koordinatnih osi inercijalnog sustava
    plot3(100*[-1,1],[0,0],[0,0],'Color','red','Linewidth',0.75);
    hold on;
    plot3([0,0],100*[-1,1],[0,0],'Color','green','Linewidth',0.75);
    plot3([0,0],[0,0],100*[-1,1],'Color','blue','Linewidth',0.75);
    
    % Crtanje baznih vektora koordinatnog sustava tijela
    arrow3d([0,Rbi(1,1)],[0,Rbi(2,1)],[0,Rbi(3,1)],0.8,0.02,0.04,'red');
    arrow3d([0,Rbi(1,2)],[0,Rbi(2,2)],[0,Rbi(3,2)],0.8,0.02,0.04,'green');
    arrow3d([0,Rbi(1,3)],[0,Rbi(2,3)],[0,Rbi(3,3)],0.8,0.02,0.04,'blue');
    
    % Crtanje stranica tijela
    fill3(LW(1,:),LW(2,:),LW(3,:),[1,0.85,0.04],'Facealpha',p);
    fill3(RW(1,:),RW(2,:),RW(3,:),[1,0.85,0.04],'Facealpha',p);
    fill3(LS(1,:),LS(2,:),LS(3,:),[1,0.85,0.04],'Facealpha',p);
    fill3(RS(1,:), RS(2,:), RS(3,:), [1 0.85 0.04],'Facealpha',p);
    
    axis equal;
    grid on;
    xlim(2*[-1,1]);
    ylim(2*[-1,1]);
    zlim(2*[-1,1]);
    set(gca,'TickLabelInterpreter','latex','FontSize',12);
    xlabel('$x$','Interpreter','latex');
    ylabel('$y$','Interpreter','latex');
    zlabel('$z$','Interpreter','latex');
    
%     view([-90, 0]);


end

