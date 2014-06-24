%
%
%
global BAF_MAGIC = 'baf1';

%
% BAF_ID   : name -> code
% BAF_TYPE : code -> name
%
global BAF_ID   = struct;
global BAF_TYPE = struct;

%%
%% Probably a better way to 
%% arrange these constants...
%% 
BAF_ID.none = 0x0;
BAF_ID.bool = 0x1;
BAF_ID.true = 0x2;
BAF_ID.false = 0x3;
BAF_ID.uint8 = 0x20;
BAF_ID.uint16 = 0x21;
BAF_ID.uint32 = 0x22;
BAF_ID.uint64 = 0x23;
BAF_ID.int8 = 0x24;
BAF_ID.int16 = 0x25;
BAF_ID.int32 = 0x26;
BAF_ID.int64 = 0x27;
BAF_ID.float32 = 0x28;
BAF_ID.float64 = 0x29;
BAF_ID.complex64 = 0x30;
BAF_ID.complex128 = 0x31;
BAF_ID.array = 0x40;
BAF_ID.user = 0x60;
BAF_ID.baf = 0x62;
BAF_ID.list = 0x94;
BAF_ID.dict = 0xac;
BAF_ID.odict = 0xbc;
BAF_ID.string = 0xc0;
%%%%

%% not sure the best way to map integer to 
%% string in MATLAB.  
BAF_TYPE.x00 = 'none';
BAF_TYPE.x10 = 'bool';
BAF_TYPE.x20 = 'true';
BAF_TYPE.x30 = 'false';
BAF_TYPE.x20 = 'uint8';
BAF_TYPE.x21 = 'uint16';
BAF_TYPE.x22 = 'uint32';
BAF_TYPE.x23 = 'uint64';
BAF_TYPE.x24 = 'int8';
BAF_TYPE.x25 = 'int16';
BAF_TYPE.x26 = 'int32';
BAF_TYPE.x27 = 'int64';
BAF_TYPE.x28 = 'float32';
BAF_TYPE.x29 = 'float64';
BAF_TYPE.x30 = 'complex64';
BAF_TYPE.x31 = 'complex128';
BAF_TYPE.x40 = 'array';
BAF_TYPE.x60 = 'user';
BAF_TYPE.x62 = 'baf';
BAF_TYPE.x94 = 'list';
BAF_TYPE.xac = 'dict';
BAF_TYPE.xbc = 'odict';
BAF_TYPE.xc0 = 'string';


function dtype = baf_get_dtype(dtypeid)
%
% This is ugly. Not sure best way
% to map: integer -> string.
% Store hex string repr as fields in a struct.
%

global BAF_TYPE

tmp = ['x' lower(dec2hex(dtypeid,2))];
if ~isfield(BAF_TYPE, tmp)
  error(sprintf('Unknown array dtype: %d (%s)', dtypeid, tmp));
else
  dtype = getfield(BAF_TYPE,tmp);
end

endfunction
