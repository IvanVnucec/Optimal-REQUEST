% =========================== Info ==============================
% Run all the tests
%
% Author:     Ivan Vnucec
% University: FER, Zagreb
% Date:       Jul, 2021
% License:    MIT

% =========================== START =============================

% Run Optimal-REQUEST and check the RMS errors
% We will run it 10 times because we have random measurements generator
for i = 1 : 10
   test_passed = test_OR_rms_error(); 
   if test_passed == false
       fprintf("TEST FAILED: RMS Error is greather than threshold value"); 
       exit(1); % exit fail
   end
end

fprintf("All test SUCCESS");
exit(0); % exit success

