interface intf (input logic pclk,preset);
  
  logic [7:0] paddr;
  logic [31:0] pwdata;
  logic [31:0] prdata;
  logic psel;
  logic pwrite;
  logic penable;
  logic pready;

  //coverage in interface

  covergroup cg@(posedge pclk);
	 
	  address:coverpoint paddr {
		   bins b1[]={16,32,48,255};
		   //ignore_bins b10[]={[0:15],[17:31],[33:47],[49:254]};

          }

          w_data:coverpoint pwdata{
		 bins b2[]={[0:100],[50:100],[100:150],[150:200],[200:255]};
		  //bins b2[]={[0:2147483647]};
	         // ignore_bins b3[]={[256:300]};
		  //illegal_bins b4[]={[300:350]};
	  }

	  r_data:coverpoint prdata{
		  bins b4[]={[0:100],[50:100],[100:150],[150:200],[200:255]};
	        //  ignore_bins b5[]={[256:300]};
		  //illegal_bins b11[]={[300:350]};
	  }

	  select:coverpoint psel{
		  bins b6[]={0,1};
          } 

	  write_read:coverpoint pwrite{
		  bins read  = {0};
	          bins write = {1};
	  }
	 
	  enable:coverpoint penable{
		  bins b7[]={0,1};
          }

	  ready:coverpoint pready{
		  bins b8[]={0,1};
          }

  endgroup:cg
  initial begin
  cg cover_inst=new();
  cover_inst.get_coverage;
  end
endinterface
