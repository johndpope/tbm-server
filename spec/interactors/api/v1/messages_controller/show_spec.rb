require 'rails_helper'

RSpec.describe Api::V1::MessagesController::Show do
  let(:user) { create(:user) }
  let(:connected_friend) do
    friend = create(:user)
    create(:established_connection, creator: user, target: friend)
    friend
  end
  let(:default_params) { { user: user, id: message.key2 } }

  describe '.run' do
    def self.shared_context_specs
      it { expect(subject.valid?).to be_truthy }
      xit { expect(subject.result).to eq('type' => 'video') }
    end

    subject { described_class.run(default_params) }

    context 'when type is persisted in value' do
      let(:message) { Kvstore.add_message_id_key('video', connected_friend, user, gen_message_id) }

      before do
        create(:message,
          sender: connected_friend.mkey, receiver: user.mkey,
          message_id: message.key2, transcription: 'hello world')
      end

      it { expect(subject.valid?).to be_truthy }
      it { expect(subject.result).to eq(type: 'video', transcription: 'hello world') }
    end

    context 'when type isn\'t persisted in value' do
      let(:message) { Kvstore.add_id_key(connected_friend, user, gen_message_id) }

      it { expect(subject.valid?).to be_truthy }
      it { expect(subject.result).to eq({}) }
    end
  end
end
