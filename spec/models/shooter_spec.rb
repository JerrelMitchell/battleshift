require 'rails_helper'

RSpec.describe Shooter, type: :model do
  # before :each do
    # this_board = Board.new(4)
    # this_target = 'A1'
  #   @shooter = Shooter.new(board: this_board, target: this_target)
  # end

  it "should return false for invalid shot" do
    this_board = Board.new(4)
    bad_target = '11'
    shooter = Shooter.new(board: this_board, target: bad_target)

    expect(shooter.valid_shot?).to be_falsy
  end

  it "should attack for valid shot" do
    this_board = Board.new(4)
    bad_target = 'A1'
    shooter = Shooter.new(board: this_board, target: bad_target)

    expect(shooter.valid_shot?).to be_truthy
  end
end
