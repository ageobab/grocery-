require 'spec_helper'

describe StoresController do
  describe '#index' do
    example do
      store = create(:store)
      get :index, user_id: store.user_id
      expect(assigns(:stores)).to_not be_empty
    end
  end
  #test to make sure only a user.store_owner can create a store
  describe '#create' do
    example do
      user = create(:user)
      user.stores << create(:store)
      expect(user.stores.count).should eq(0)
    end
    example do
      user = create(:user, store_owner: true)
      user.stores << create(:store)
      expect(user.stores.count).should eq(1)
    end
  end
  #test to make sure only a user.store_owner can update a store
  describe '#update' do
    example do
      user = create(:user)
      user.stores << create(:store)
      user.stores.last.should_receive(:update_attributes!).with(name: "new name").and_return(:false)
      expect(user.stores.last.save).to eq(false)
    end
    example do
      user = create(:user, store_owner: true)
      user.stores << create(:store)
      user.stores.last.should_receive(:update_attributes!).with(name: "new name").and_return(:true)
      expect(user.stores.last.save).to eq(true)
    end
  end
  # #only a user.store_owner should be able to delete a store
  describe '#destoy' do
    example do
      user = create(:user)
      store = create(:store)
      user.stores << store
      delete :destroy,{ user_id: store.user.id, id: store.id }
      expect(user.stores.count).should eq(1)
    end
    example do
      user = create(:user, store_owner: true)
      store = create(:store)
      user.stores << store
      delete :destroy,{ user_id: store.user.id, id: store.id }
      expect(user.stores.count).should eq(0)
    end
  end
end
