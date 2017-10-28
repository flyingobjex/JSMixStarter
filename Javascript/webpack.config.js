const CopyWebpackPlugin = require('copy-webpack-plugin');
const path = require('path');

module.exports = {
    entry: './index.js',
    target: 'node',
    output: {
        path: path.resolve('./build'),
        filename: "bundle.js",
        libraryTarget: 'var',
        library: 'app',
    },
    devServer: {
        contentBase: './build'
    },
    module: {
        loaders: [
            {
                test: /\.js$/,
                exclude: /(node_modules)/,
                loader: 'babel-loader',
                query: {
                    presets: ['es2015']
                }
            }
        ]
    },
    plugins: [
        new CopyWebpackPlugin([

            // {output}/to/file.txt
            { from: 'build/bundle.js', to: '../../JSMixStarter/js/index.js' },

            // // {output}/to/directory/file.txt
            // { from: 'from/file.txt', to: 'to/directory' },
            //
            // // Copy glob results to /absolute/path/
            // { from: 'from/directory/**/*', to: '/absolute/path' },

        ], {

            // By default, we only copy modified files during
            // a watch or webpack-dev-server build. Setting this
            // to `true` copies all files.
            copyUnmodified: false
        })
    ]
};