require 'spec_helper'

describe BrainRubyck do 

  let(:hello_world_code) { '++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.' }
  let(:br) { BrainRubyck.new }

  describe ".new" do
    it "returns a new BrainRubyck object with defaults" do
      br.code.should eql ""
      br.logging.should eql false
      br.dump_all.should eql false
    end
  end

  describe "#code" do
    it "is empty on initialization" do
      br.code.should eql ""
    end
    it "is accessible" do
      br.code = "+++"
      br.code.should eql "+++"
    end
  end

  describe "#parse!" do
    it "returns the output" do
      br.parse!.should_not be_nil
    end
    it "return has length equal to the number of . commands" do
      br.code = "+++...+++...+++...>>>...<<<..."
      br.parse!.length.should eql 15
    end
    it 'returns \'Hello World!\n\' when using the Hello World program' do
      br.code = hello_world_code
      br.parse!.should eql "Hello World!\n" 
    end
    it 'outputs \'Hello World!\n\' to STDOUT when using the Hello World program' do
      output = capture_stdout do 
        br.code = hello_world_code
        br.parse!
      end
      output.should eql "Hello World!\n"
    end
    it "logs the output to @out" do
      br.code = '++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.'
      br.parse!
      br.out.should eql "Hello World!\n"
    end
    it "starts the cursor at 0" do
      br.code = ""
      br.cursor.should eql 0
    end
    it "increments the current memory position with +" do
      br.code = "+"
      br.parse!
      br.memory[br.cursor].should eql 1
    end
    it "decrements the current memory position with -" do
      br.code = "-"
      br.parse!
      br.memory[br.cursor].should eql -1
    end
    it "increments the cursor with >" do
      br.code = ">"
      br.parse!
      br.cursor.should eql 1
    end
    it "decrements the cursor with <" do
      br.code = "<"
      br.parse!
      br.cursor.should eql -1
    end
    it "loops while current value != 0 with [ and ]" do
      br.code = "++[-]"
      br.parse!
      br.memory[br.cursor].should eql 0
    end
  end

end