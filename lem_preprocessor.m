function  [K,f,d] = lem_preprocessor
lem_include_flags;

lem_input_file_1ele;
%lem_input_file_16ele;


% generate ID array and LM array 
d = lem_setup_ID_LM(d);





