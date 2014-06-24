function bafwrite(filename, x)
%function bafwrite(filename, x)
%
% Write the variable 'x' to BAF file at path 'filename'
%

bafconstants;

fd = fopen(filename,'wb');
if fd == -1
  error(['Could not open file: ' filename]);
end

%% fwrite:
%COUNT = fwrite (FID, DATA, PRECISION, SKIP, ARCH)

fmt = 'l';

%% 'baf1':
c = fwrite(fd, [98, 97, 102, 49], 'uint8', 0, fmt);
assert(c==4);

c = fwrite(fd, 0, 'uint32', 0, fmt);
assert(c==1);

c = fwrite(fd, 0, 'uint32', 0, fmt);
assert(c==1);

_bafwrite(fd,x);

fclose(fd);

endfunction


function _w_typeid(fd,name)
global BAF_ID;

c = fwrite(fd, getfield(BAF_ID,name), 'uint8');
assert(c==1);
endfunction


%%
%% helpers for each type.
%%
function _w_bool(fd,x)
if x
  _w_typeid(fd, 'true');
else
  _w_typeid(fd, 'false');
end
endfunction


function _w_string(fd,x)
_w_typeid(fd, 'string');

% UTF-8 ????

c = fwrite(fd, length(x), 'uint32', 0, 'l');
assert(c==1);

fprintf(fd, '%s', x);

endfunction



function _bafwrite(fd,x)
%
%
%

if isstruct(x)
  
  disp('struct');
  keys = fieldnames(x);
  for i=1:length(keys)
    disp(['KEY: ' keys{i}]);
  end

elseif ischar(x)
  _w_string(fd,x);
  
elseif isfloat(x)

  disp('float');
  
  sz = size(x)

elseif islogical(x)
  
  if isscalar(x)
    _w_bool(fd,x)
  else
    disp('not impl');
  end
  
else
  disp('type??');
  disp(class(x));
  error('Unhandled type');
  
end

endfunction
