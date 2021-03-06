require 'spec_helper_acceptance'

describe 'splunk::forwarder class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class { '::splunk::params':
      }
      class { '::splunk::forwarder':
        splunkd_port => 8090,
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe package('splunkforwarder') do
      it { is_expected.to be_installed }
    end

    describe service('splunk') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
