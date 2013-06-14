require 'spec_helper'

describe 'AuditLog' do
  let(:branch) { Branch.first }
  let(:user) { User.where(name: 'user1').first }

  context 'Class' do

    context '.transcribe' do

      context 'not valid' do
        subject { User.transcribe }
        it { expect(subject).to be_false }
      end

      context 'valid' do
        let(:audit) { ::Audit::AuditLog.last }
        subject { User.transcribe(user: user, view_name: 'test', action_name: 'audits#search', crud_name: 'search', opts: {type: 'Search::Post'}) }
        it { expect(subject).to be_true }

        context 'crud_name=' do
          it { expect(audit.crud_name).to eq('search') }
        end

        context 'action_name=' do
          it { expect(audit.action_name).to eq('audits#search') }
        end

      end

    end

  end

  context 'Model' do
    let(:post1) { Post.where(title: 'aaa').first }
    let(:post2) { Post.where(title: 'ccc').first }
    let(:post_audit) { Post.auditable.last }

    context '#transcribe' do
      context 'not valid' do
        subject { post1.transcribe }
        it { expect(subject).to be_false }
      end

      context 'valid' do
        subject { post1.transcribe(user: user, view_name: 'posts', action_name: 'posts#create', crud_name: 'create') }
        it { expect(subject).to be_true }

        context 'crud_name=' do
          it { expect(post_audit.crud_name).to eq('create') }
        end

        context 'action_name=' do
          it { expect(post_audit.action_name).to eq('posts#create') }
        end

      end
    end

    context 'increments object stack count' do
      let(:increment) { post1.transcribe(user: user, view_name: 'abc', action_name: 'abc#update', crud_name: 'update') }
      it { expect{ increment }.to change{ post1.audits.count }.from(1).to(2) }
    end

    context 'total model stack count' do
      subject { post2.transcribe(user: user, view_name: 'posts', action_name: 'posts#create', crud_name: 'create') }
      it { expect{ subject }.to change{ Post.auditable.count }.from(2).to(3) }
    end

    context 'raise a NoMethodError' do
      it { expect{ branch.audits }.to raise_error(NoMethodError) }
    end

  end

  context 'audit_log force: true' do
    context '#snapping' do
      let(:comment_audit) { Comment.auditable.last }

      context '#after_create' do
        subject { user.comments.create(description: 'comment') }
        it { expect{ subject }.to change{ Comment.auditable.count }.from(0).to(1) }

        context 'crud_name=' do
          it { expect(comment_audit.crud_name).to eq('create') }
        end
      end

      context '#after_update' do
        let(:comment) { user.comments.first }
        subject { comment.update_attributes(description: 'mogemoge') }
        it { expect{ subject }.to change{ Comment.auditable.count }.from(1).to(2) }

        context 'crud_name=' do
          it { expect(comment_audit.crud_name).to eq('update') }
        end

      end

      context '#before_destroy' do
        let(:comment) { user.comments.first }
        subject { comment.destroy }
        it { expect{ subject }.to change{ Comment.auditable.count }.from(2).to(3) }

        context 'crud_name=' do
          it { expect(comment_audit.crud_name).to eq('delete') }
        end

      end
    end

  end

end
