require "spec_helper"

describe "ConnectFour" do 

  it "initializes with an empty board" do 
    game = ConnectFour.new("red")
    expect(game.board).to eq([[" ", " ", " ", " "],[" ", " ", " ", " ", " "],[" ", " ", " ", " "],[" ", " ", " ", " "]])
  end
end