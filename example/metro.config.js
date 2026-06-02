const {getDefaultConfig, mergeConfig} = require('@react-native/metro-config');
const path = require('path');

const root = path.resolve(__dirname, '..');

/**
 * Metro configuration for the example app.
 * Watches the parent SDK directory so changes to the SDK are
 * picked up immediately without re-installing.
 */
const config = {
  watchFolders: [root],
  resolver: {
    // Make the SDK's react-native peer dep resolve from example/node_modules,
    // not from the SDK root (which has no node_modules of its own).
    nodeModulesPaths: [
      path.resolve(__dirname, 'node_modules'),
      path.resolve(root, 'node_modules'),
    ],
  },
};

module.exports = mergeConfig(getDefaultConfig(__dirname), config);
