require 'spec_helper'

RSpec.describe Todo, type: :aruba do
  let!(:active_task) { create(:task) }
  let!(:completed_task) { create(:task, completed_at: Time.current) }

  it 'display usage' do
    run_command('todo')

    expect(last_command_started).to have_output(/Usage: todo/)
  end

  it 'lists active todos' do
    run_command('todo ls')

    expect(last_command_started).to have_output(/#{active_task.id} - #{active_task.name}/)
  end

  it 'lists completed todos' do
    run_command('todo ls completed')

    expect(last_command_started).to have_output(/#{completed_task.id} - #{completed_task.name}/)
  end

  it 'adds a todo' do
    task_name = build(:task).name
    run_command("todo add #{task_name}")

    expect(last_command_started).to have_output(/Added: #{task_name}/)
    expect(::Todo::Task.exists?(name: task_name)).to be_truthy
  end
end
