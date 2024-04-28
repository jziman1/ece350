// 

module control(
    input clock,
    input wire motors_inst,
    input wire ctrl_motors,
    input wire [26:0] servo_time,
    output reg servo_enable,
    output reg motor_enable,
    output reg done
    );

    reg [36:0] servoCounter = 0;
    reg [36:0] motorCounter = 0;
    reg [36:0] delayCounter_1 = 0;
    reg [36:0] delayCounter_2 = 0;

    always @(negedge clock) begin
        if (motors_inst == 1'b1) begin
            if (ctrl_motors == 1'b1) begin
                servoCounter = 0;
                motorCounter = 0;
                delayCounter_1 = 0;
                delayCounter_2 = 0;
                done = 0;
            end
            
            if (servoCounter < 500000*servo_time) begin // 0.1 second per servo_time
            // if (servoCounter < servo_time) begin // For testing purposes
                servoCounter = servoCounter + 1;
                servo_enable = 1;
            end else begin
                servo_enable = 0;
                if (delayCounter_2  < 1*49999999) begin // Delay for three seconds
                    delayCounter_2  = delayCounter_2 + 2;
                end else begin
                    if (motorCounter < 49999999) begin // Motor on for one second
                    // if (motorCounter < 2) begin // For testing purposes
                        motorCounter = motorCounter + 1;
                        motor_enable = 1;
                    end else begin
                        motor_enable = 0;
                        if (delayCounter_1  < 3*49999999) begin // Delay for three seconds
                            delayCounter_1  = delayCounter_1 + 1;
                        end else begin
                            done = 1; // Stall if instruction == custom instruction and done == 0
                    end
                end
            end
        end
        end else begin
            servo_enable = 0;
            motor_enable = 0;
            done = 0;
        end
   end

endmodule