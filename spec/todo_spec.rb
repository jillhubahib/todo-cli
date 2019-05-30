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

  it 'modify an existing todo' do
    task_id = active_task.id
    task_name = 'Dancing'
    run_command("todo edit #{task_id} #{task_name}")

    expect(last_command_started).to have_output(/Edited: #{task_name}/)
    expect(::Todo::Task.exists?(name: task_name)).to be_truthy
  end

  it 'modify a non existent todo' do
    task_name = 'Dancing'
    task_id = -1
    run_command("todo edit #{task_id} #{task_name}")
    expect(last_command_started).to have_output(/Edited: NUM:-1 not found! Try again./)
    expect(::Todo::Task.exists?(name: task_name)).to be_falsey
  end

  it 'completes a todo' do
    run_command("todo done #{active_task.id}")

    expect(last_command_started).to have_output(/Done: #{active_task.name}/)
    expect(active_task.reload.completed_at).not_to be_nil
  end

  it 'deletes a todo' do
    run_command("todo delete #{completed_task.id}")

    expect(last_command_started).to have_output(/Deleted: #{completed_task.name}/)
    expect(::Todo::Task.find_by(id: completed_task.id)).to be_nil
  end

  it 'removes all todo' do
    run_command("todo clear")

    expect(last_command_started).to have_output(/All todos cleared/)
    expect(::Todo::Task.all.size).to be_zero
  end
end
