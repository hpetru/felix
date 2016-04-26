require 'rails_helper'

describe StudentGroupsController do
  describe '#index' do
    it 'display student groups' do
      student_groups = [*1..10].map { create(:student_group) }
      sign_in create(:user)
      get :index

      expect(assigns(:student_groups)).to eq(
        student_groups
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
        post :create, student_group: {
          promotion: 2015,
          suffix: 'A',
          profile_slug: 'real'
        }
        student_group = StudentGroup.first

        expect(StudentGroup.count).to eq 1
        expect(student_group.promotion).to eq 2015
        expect(response).to redirect_to(student_groups_path)
      end
    end

    context 'with invalid inputs' do
      it 'don\'t create a new record' do
        sign_in create(:user)
        post :create, student_group: {
          promotion: 'abc'
        }

        expect(StudentGroup.count).to eq 0
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#edit' do
    it 'display edit form' do
      student_group = create(:student_group)
      sign_in create(:user)
      get :edit, id: student_group.id

      expect(assigns(:student_group)).to eq(
        student_group
      )
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    context 'with valid inputs' do
      it 'update existent record' do
        student_group = create(:student_group, suffix: 'A')
        sign_in create(:user)
        put :update, id: student_group.id, student_group: {
          suffix: 'C'
        }
        student_group.reload

        expect(student_group.suffix).to eq 'C'
        expect(response).to redirect_to(
          student_groups_path
        )
      end
    end

    context 'with invalid inputs' do
      it 'render :edit view' do
        student_group = create(:student_group, suffix: 'A')
        sign_in create(:user)
        put :update, id: student_group.id, student_group: {
          suffix: ''
        }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy' do
    it 'delete existent record' do
      student_group = create(:student_group)
      sign_in create(:user)
      delete :destroy, id: student_group.id

      expect(StudentGroup.count).to eq 0
    end
  end
end
