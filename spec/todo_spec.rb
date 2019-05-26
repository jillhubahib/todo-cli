require 'spec_helper'

RSpec.describe Todo, type: :aruba do
  it 'display usage' do
    run_command('todo')

    expect(last_command_started).to have_output(/Usage: todo/)
  end
end
