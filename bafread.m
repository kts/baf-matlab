function x = bafread(filename)
%function x = bafread(filename)
%
% Read BAF from filename.
% 

bafconstants;

fd = fopen(filename);
if fd == -1
  error(['Could not open file: ' filename]);
end

%%% header

magic = fscanf(fd,'%c',4);
assert(strcmp(magic,BAF_MAGIC));

% note:
%   fread(fd, num, type, skip,machinefmt)
fmt = 'l';

nb = fread(fd, 1, 'uint32', 0, fmt);
fseek(fd, nb, SEEK_CUR);

nb = fread(fd, 1, 'uint32', 0, fmt);
fseek(fd, nb, SEEK_CUR);

%%% end header

typeid = fread(fd,1);

% switch?
switch typeid
  
  case BAF_ID.array

   nbytes = fread(fd,1, 'uint32',0,'l');
  
   dtypeid = fread(fd, 1);
   
   dtype = baf_get_dtype(dtypeid);
  
   byte = fread(fd, 1);
   rank = bitand(byte, 0x0f);
   
   flags = bitshift(byte, -4);
   if flags ~= 0
     error('Not implemented: non-zero flag byte in array');
   else
     is_c_order = 1;  
   end

   n1 = fread(fd,1, 'uint32',0,'l');
   n2 = fread(fd,1, 'uint32',0,'l');
   
   numel = n1 * n2;
   
   % Is there are more efficent way?
   % - especially if needing to change order or type...
  
   x = fread(fd,numel,dtype);
   assert(length(x) == numel);
   
   if is_c_order
     x = reshape(x,n1,n2);
   else
     x = reshape(x,n2,n1)';
   end
   
 otherwise
  
  %% dict: setfield(d,'key',value)
  
  error(['Unknown type id:' num2str(typeid)]);
 endswitch
  
end
