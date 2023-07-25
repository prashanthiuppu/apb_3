module apb_slave
#(
  addrWidth = 8,
  dataWidth = 32
)
(
  input                        pclk,
  input                        preset,
  input        [addrWidth-1:0] paddr,
  input                        pwrite,
  input                        psel,
  input                        penable,
  input        [dataWidth-1:0] pwdata,
  output logic [dataWidth-1:0] prdata,
  output logic pready
);

logic [dataWidth-1:0] mem [256];

logic [1:0] apb_st;
const logic [1:0] SETUP_PHASE = 0;
const logic [1:0] W_ENABLE = 1;
const logic [1:0] R_ENABLE = 2;

// SETUP_PHASE -> ENABLE
always @(negedge preset or posedge pclk) begin
  if (preset == 0) begin
    apb_st <= 0;
    prdata <= 0;
  end

  else begin
    case (apb_st)
      SETUP_PHASE : begin
        // clear the prdata
        prdata <= 0;
	pready <=1;

        // Move to ENABLE when the psel is asserted
        if (psel && !penable) begin
          if (pwrite) begin
            apb_st <= W_ENABLE;
          end

          else begin
            apb_st <= R_ENABLE;
          end
        end
      end

      W_ENABLE : begin
        // write pwdata to memory
        if (psel && penable && pwrite) begin
          mem[paddr] <= pwdata;
        end

        // return to SETUP_PHASE
        apb_st <= SETUP_PHASE;
      end

      R_ENABLE : begin
        // read prdata from memory
        if (psel && penable && !pwrite) begin
          prdata <= mem[paddr];
        end

        // return to SETUP_PHASE
        apb_st <= SETUP_PHASE;
      end
    endcase
  end
end 


endmodule





/*module apb_slave (
  input pclk,preset,psel,pwrite,penable,
  input [7:0]paddr,
  input [31:0]pwdata,
  output reg [31:0]prdata,
  output reg pready
  );
  
  //declaring parameters
  parameter IDLE=0, SETUP=1, ENABLE=2;
  reg [1:0] pstate, nstate;
  reg [31:0] mem[2**15:0]; // Slave Memory
  
  //FSM reset logic 
  always@(posedge pclk or negedge preset)
    begin 
      if(preset)
        pstate <= IDLE;
      else begin  
        pstate <= nstate;
        pready <= 1'b1;
    end
    end
  //fsm state logic
  
  always@(psel or penable)
    begin
      case(pstate)
        IDLE: 
          begin
            if(psel) begin
              nstate <= SETUP;//if select is on then it will go to SETUP state

            end
            else
              nstate <= IDLE;
          end
        SETUP:
          begin
            if(psel && penable)
              nstate <= ENABLE;			//if ENABLE id on then transaction take place
            else 
              nstate <= SETUP;
          end
        ENABLE:
          begin
            if(psel)
              nstate <= SETUP;		//still there is select is high then it retuns to select
            else
              nstate <= IDLE;
          end
        default : nstate <= IDLE;  //no transaction
      endcase
    end
        
            
  //FSM output logic
  always @(penable or pstate or psel)
    begin
      case(pstate)
        IDLE: 
          prdata <= 16'h0;
        SETUP: 
          prdata <= 16'h0;
        ENABLE:
          begin
            if(pwrite)
              begin
                mem[paddr] <= pwdata;
              end
            else 
              begin
                prdata <= mem[paddr];
              end
          end
        default:
          prdata <= 16'h0;
      endcase
    end
endmodule */  
