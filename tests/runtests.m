x = bafread('/tmp/array.2x3.int32.baf')
x = bafread('/tmp/array.2x3.int16.baf')
x = bafread('/tmp/array.2x3.int8.baf')
%x = bafread('/tmp/out.baf')

disp('**** Some sanity checks about type introspection in Matlab ****');

assert(islogical(0)    == 0)
assert(islogical(true) == 1)

assert(isinteger(0)    == 0)
assert(isfloat(0)      == 1)
assert(isfloat([0 0])  == 1)

assert(strcmp(class(true),'logical'));
assert(strcmp(class(0),   'double'));

assert(strcmp(class(uint8(1)),  'uint8'));
assert(strcmp(class(uint16(1)), 'uint16'));
assert(strcmp(class(uint32(1)), 'uint32'));
assert(strcmp(class(uint64(1)), 'uint64'));

assert(strcmp(class(int8(1)),  'int8'));
assert(strcmp(class(int16(1)), 'int16'));
assert(strcmp(class(int32(1)), 'int32'));
assert(strcmp(class(int64(1)), 'int64'));

% isscalar()  (1 iff size(x)==[1 1])
% ismatrix()

bafwrite('/tmp/out0.baf', true);
bafwrite('/tmp/out1.baf', false);

%bafwrite('/tmp/out1.baf', rand(3));
%bafwrite('/tmp/out2.baf', 'abc');
%ones

x = reshape(0:5,3,2)';
%y = uint8(x);
%...
bafwrite('/tmp/out-array.2x3.int8.baf',  int8(x));
bafwrite('/tmp/out-array.2x3.int16.baf', int16(x));

bafwrite('/tmp/out10.baf', 'okay')

x = struct();
x.aa = 1;
x.bb = 'okay';
bafwrite('/tmp/out3.baf', x);
