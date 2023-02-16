import { AppRegistry, Platform } from 'react-native';
import { name as appName } from './app.json';

// Uncomment AutofillExtension component if you need to check how Extension works without reanimated
import App from './src/App';
// import AutofillExtension from './src/AutofillExtension';

AppRegistry.registerComponent(appName, () => App);
// AppRegistry.registerComponent(appName, () => AutofillExtension);

// TODO(Bacon): When `expo` has removed Updates, replace this with using the `expo` entry for better error handling
if (Platform.OS === 'web') {
  const rootTag = document.getElementById('root');
  AppRegistry.runApplication(appName, { rootTag });
}
