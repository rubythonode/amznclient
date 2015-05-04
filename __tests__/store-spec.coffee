jest.autoMockOff()
Deferred = require('deferred')
jest.autoMockOn()

describe 'ItemStore', ->
  deferred = store = null

  beforeEach ->
    deferred = Deferred()
    jest.setMock('uuid', {})
    jest.setMock 'react-native',
      AsyncStorage:
        getItem: -> deferred.promise()

    StoreClass = require.requireActual './../coffee/stores/store.cjsx'
    store = new StoreClass

  describe '#constructor', ->
    describe 'checks storage for a uuid', ->
      describe 'uuid exists', ->
        beforeEach ->
          deferred.resolve('api key')

        it 'saves a reference to the key', ->
          expect(store.apiKey).toEqual('api key')

      describe 'uuid does not exist', ->