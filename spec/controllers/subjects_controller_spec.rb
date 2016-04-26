require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  describe '#index' do
    it 'display subjects' do
      subjects = [*1..10].map { create(:subject) }
      sign_in create(:user)
      get :index

      expect(assigns(:subjects)).to eq(
        subjects
      )
    end
  end

  describe '#new' do
    it 'display form' do
      sign_in create(:user)
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    context 'with valid inputs' do
      it 'create a new record' do
        sign_in create(:user)
        post :create, subject: {
          name: 'Matematica'
        }
        subject = Subject.first

        expect(Subject.count).to eq 1
        expect(subject.name).to eq 'Matematica'
        expect(response).to redirect_to(subjects_path)
      end
    end

    context 'with invalid inputs' do
      it 'don\'t create a new record' do
        sign_in create(:user)
        post :create, subject: {
          name: ''
        }

        expect(Subject.count).to eq 0
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#edit' do
    it 'display edit form' do
      subject = create(:subject)
      sign_in create(:user)
      get :edit, id: subject.id

      expect(assigns(:subject)).to eq(
        subject
      )
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    context 'with valid inputs' do
      it 'update existent record' do
        subject = create(:subject, name: 'Matematica')
        sign_in create(:user)
        put :update, id: subject.id, subject: {
          name: 'Istoria'
        }
        subject.reload

        expect(subject.name).to eq 'Istoria'
        expect(response).to redirect_to(
          subject_path
        )
      end
    end

    context 'with invalid inputs' do
      it 'render :edit view' do
        subject = create(:subject)
        sign_in create(:user)
        put :update, id: subject.id, subject: {
          name: ''
        }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy' do
    it 'delete existent record' do
      subject = create(:subject)
      sign_in create(:user)
      delete :destroy, id: subject.id

      expect(Subject.count).to eq 0
    end
  end
end
