require 'open3'
require 'spec_helper'

describe 'Running a gitsh script' do
  it 'runs the script and exits' do
    in_a_temporary_directory do
      write_file('myscript.gitsh', "init\ncommit --allow-empty -m First")

      out, err, status = Open3.capture3("#{gitsh} myscript.gitsh")

      expect(err).to eq ''
      expect(status).to be_success

      out, err, status = Open3.capture3("/usr/bin/env git log --oneline")

      expect(err).to eq ''
      expect(out).to match /^[a-z0-9]+ First\n$/
      expect(status).to be_success
    end
  end

  it 'exits with a useful error when the script does not exist' do
    in_a_temporary_directory do
      out, err, status = Open3.capture3("#{gitsh} nosuchscript.gitsh")

      expect(err).to eq "gitsh: Error: No such file or directory - nosuchscript.gitsh\n"
      expect(status.exitstatus).to eq 66
    end
  end

  def gitsh
    File.expand_path('../../../bin/gitsh', __FILE__)
  end
end
