library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_custom_axi_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 4
	);
	port (
		-- Users to add ports here
        pwm_ouput : out std_logic;
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic
	);
end pwm_custom_axi_v1_0;

architecture arch_imp of pwm_custom_axi_v1_0 is
    signal sig_enable : std_logic;
    signal sig_period : std_logic_vector(26 DOWNTO 0);
    signal sig_duty   : std_logic_vector(26 DOWNTO 0);
    
    constant clk_freq   : integer := 100000000;  -- 100MHz
    constant clk_period : time := 10 ns;
    
    signal count_sig    : integer range 0 to clk_freq := 0;  --up to one second (clk_freq/1sec = clk_freq)
    signal output_sig   : std_logic;
    signal enable_sig   : std_logic;
    
	-- component declaration
	component pwm_custom_axi_v1_0_S00_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		enable : out std_logic;
		period : out std_logic_vector(26 DOWNTO 0);
		duty : out std_logic_vector(26 DOWNTO 0);
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component pwm_custom_axi_v1_0_S00_AXI;

begin

-- Instantiation of Axi Bus Interface S00_AXI
pwm_custom_axi_v1_0_S00_AXI_inst : pwm_custom_axi_v1_0_S00_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
	)
	port map (
	    period => sig_period,
	    enable => sig_enable,
	    duty => sig_duty,
		S_AXI_ACLK	=> s00_axi_aclk,
		S_AXI_ARESETN	=> s00_axi_aresetn,
		S_AXI_AWADDR	=> s00_axi_awaddr,
		S_AXI_AWPROT	=> s00_axi_awprot,
		S_AXI_AWVALID	=> s00_axi_awvalid,
		S_AXI_AWREADY	=> s00_axi_awready,
		S_AXI_WDATA	=> s00_axi_wdata,
		S_AXI_WSTRB	=> s00_axi_wstrb,
		S_AXI_WVALID	=> s00_axi_wvalid,
		S_AXI_WREADY	=> s00_axi_wready,
		S_AXI_BRESP	=> s00_axi_bresp,
		S_AXI_BVALID	=> s00_axi_bvalid,
		S_AXI_BREADY	=> s00_axi_bready,
		S_AXI_ARADDR	=> s00_axi_araddr,
		S_AXI_ARPROT	=> s00_axi_arprot,
		S_AXI_ARVALID	=> s00_axi_arvalid,
		S_AXI_ARREADY	=> s00_axi_arready,
		S_AXI_RDATA	=> s00_axi_rdata,
		S_AXI_RRESP	=> s00_axi_rresp,
		S_AXI_RVALID	=> s00_axi_rvalid,
		S_AXI_RREADY	=> s00_axi_rready
	);

	-- Add user logic here
    process(s00_axi_aclk, s00_axi_aresetn)
      constant zero_duty    : std_logic_vector(sig_duty'range) := (others => '0');
      variable period_ticks : integer := clk_freq/to_integer(unsigned(sig_period));  -- how many tick counts needed at clock frequency to yield the desired period
      begin
        if (s00_axi_aresetn = '0') then 
          count_sig <= 0;
          output_sig <= '0';
        elsif (s00_axi_aclk'event and s00_axi_aclk = '1') then
          if (enable_sig = '1') then
            if (sig_period = sig_duty) then
              output_sig <= '1';
            elsif (sig_duty = zero_duty) then
              output_sig <= '0';
            else
              -- Set output high while within the duty
              if (count_sig <= (to_integer(unsigned(sig_duty)) * (period_ticks/(to_integer(unsigned(sig_period)))))) then  -- ticks are within the number of ticks for the duty (duty_ticks) 
                output_sig <= '1';
              else
                output_sig <= '0';
              end if;
              -- Period ticks have been hit - flip and restart pulse
              if (count_sig = period_ticks) then
                count_sig <= 0;
                output_sig <= not output_sig;
              else
                count_sig <= count_sig + 1;
              end if;
            end if;
          end if;
        end if;
      end process;
      enable_sig <= sig_enable;
      pwm_ouput <= output_sig; -- & enable
	-- User logic ends

end arch_imp;
