require 'spec_helper'

describe BrainRubyck do 

  let(:hello_world_code) { '++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.' }
  let(:br) { BrainRubyck.new }

  describe ".new" do
    it "returns a new BrainRubyck object with defaults" do
      expect(br.code).to eq ""
      expect(br.logging).to eq false
      expect(br.dump_all).to eq false
    end
  end

  describe "#code" do
    it "is empty on initialization" do
      expect(br.code).to eq ""
    end
    it "is accessible" do
      br.code = "+++"
      expect(br.code).to eq "+++"
    end
  end

  describe "#parse!" do
    it "returns the output" do
      expect(br.parse!).not_to be_nil
    end
    it "return has length equal to the number of . commands" do
      br.code = "+++...+++...+++...>>>...<<<..."
      expect(br.parse!.length).to eq 15
    end
    it 'returns \'Hello World!\n\' when using the Hello World program' do
      br.code = hello_world_code
      expect(br.parse!).to eq "Hello World!\n" 
    end
    it 'outputs \'Hello World!\n\' to STDOUT when using the Hello World program' do
      output = capture_stdout do 
        br.code = hello_world_code
        br.parse!
      end
      expect(output).to eq "Hello World!\n"
    end
    it "logs the output to @out" do
      br.code = '++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.'
      br.parse!
      expect(br.out).to eq "Hello World!\n"
    end
    it "starts the cursor at 0" do
      br.code = ""
      expect(br.cursor).to eq 0
    end
    it "increments the current memory position with +" do
      br.code = "+"
      br.parse!
      expect(br.memory[br.cursor]).to eq 1
    end
    it "decrements the current memory position with -" do
      br.code = "-"
      br.parse!
      expect(br.memory[br.cursor]).to eq -1
    end
    it "increments the cursor with >" do
      br.code = ">"
      br.parse!
      expect(br.cursor).to eq 1
    end
    it "decrements the cursor with <" do
      br.code = "<"
      br.parse!
      expect(br.cursor).to eq -1
    end
    it "loops while current value != 0 with [ and ]" do
      br.code = "++[-]"
      br.parse!
      expect(br.memory[br.cursor]).to eq 0
    end
    it "ignores comments" do
      len = hello_world_code.length
      br.code = "this is a comment" + hello_world_code + "this is another one"
      expect(br.parse!).to eq "Hello World!\n"
    end
  end

end