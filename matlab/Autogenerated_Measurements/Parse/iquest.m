function [qib_gd, NOI, J] = iquest(I, B, q_init, delta_max, alpha, N_max)
% Funkcija iques() je iterativni estimator kvaterniona koja prima matricu
% vektora u inercijalnom koordinatnom sustavu I, matricu vektora u
% koordinatnom sustavu tijela B, inicijalni kvaternion za poèetak
% iteratovnog postupa te maksimalnu dozvoljenu razliku u gresci, koja
% predstavlja kriterij za prekid iterativnog postupka.
% Funkcija iquest() vraca estimirani kvaternion qib_gd, broj treracija
% potrebnih za minimizaciju greske do zadane razine NOI i vrijednosti
% funkcije cilja J

qib_gd = q_init; % Definiran pocetno stanje kvaterniona
Rib_gd = qib2Rib(qib_gd); % Racunam pocetnu rotacijsku matricu
J = zeros(N_max,1); % Inicijaliziram vektor funkcije cilja (cost function)
NOI = N_max; % Ako rjesenje ne konvergira, broj iteracija je jednak N_max


% Pokrecem petlju s N iteracija
for i=1:N_max
    
    % Racunam matricu pogreske E
    E = Rib_gd*I - B;
    
    % Racunam vrijednost funckije cilja u i-toj iteraciji
    J(i) = trace(E'*E);
    
    % Provjeravam je li ispunjen uvjet za prekid iterativnog postupka
    if i>1
        delta_J = abs(J(i)-J(i-1));
        if delta_J < delta_max
            NOI = i;
            J = J(1:NOI);
            break;
        end
    end
    
    % Parcijalna derivacija rotacijske matrice Rib_gd po q1
    M1 = 2*[ qib_gd(1)  qib_gd(4) -qib_gd(3);
            -qib_gd(4)  qib_gd(1)  qib_gd(2);
             qib_gd(3) -qib_gd(2)  qib_gd(1)];
        
    % Parcijalna derivacija rotacijske matrice Rib_gd po q2
    M2 = 2*[ qib_gd(2)  qib_gd(3)  qib_gd(4);
             qib_gd(3) -qib_gd(2)  qib_gd(1);
             qib_gd(4) -qib_gd(1) -qib_gd(2)];
         
    % Parcijalna derivacija rotacijske matrice Rib_gd po q3
    M3 = 2*[-qib_gd(3)  qib_gd(2) -qib_gd(1);
             qib_gd(2)  qib_gd(3)  qib_gd(4);
             qib_gd(1)  qib_gd(4) -qib_gd(3)];
    
    % Parcijalna derivacija rotacijske matrice Rib_gd po q4
    M4 = 2*[-qib_gd(4)  qib_gd(1)  qib_gd(2);
            -qib_gd(1) -qib_gd(4)  qib_gd(3);
             qib_gd(2)  qib_gd(3)  qib_gd(4)];
    
    % Radi ustede vremena jednom racunam matricu A nakon cega ju
    % primjenjujem u izrazima za izracun novih elemenata kvaterniona
    A = I*E';
    
    % Primijenjujem gradient decent algoritam na svaki element kvaterniona
    q1 = qib_gd(1) - alpha*(2*trace(M1*A));
    q2 = qib_gd(2) - alpha*(2*trace(M2*A));
    q3 = qib_gd(3) - alpha*(2*trace(M3*A));
    q4 = qib_gd(4) - alpha*(2*trace(M4*A));

    % Od izracunatih elemenata slazem kvaternion
    qib_gd = [q1,q2,q3,q4]';
    
    % Zapisujem novu rotacijsku matricu za sljedecu iteraciju
    Rib_gd = qib2Rib(qib_gd);
end
end

